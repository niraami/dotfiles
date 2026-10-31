#!/usr/bin/env bash

# Toggle between the normal multi-monitor layout and HDMI (TV) only.

set -eu -o pipefail

tv="HDMI-A-1"
tv_mode="3840x2160@120"
tv_scale=2
timeout=30

notify() {
  notify-send -a "TV mode" "TV mode" "$1"
}

revert() {
  hyprctl reload >/dev/null
}

# Ignore repeated presses while the confirmation dialog is open
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/tv_mode.lock"
flock -n 9 || exit 0

# Names of currently active outputs
mapfile -t active < <(hyprctl monitors -j | jq -r '.[].name')

if [[ "${#active[@]}" -eq 1 && "${active[0]}" == "$tv" ]]; then
  revert
  exit 0
fi

if ! hyprctl monitors all -j | jq -e --arg tv "$tv" 'any(.[]; .name == $tv)' >/dev/null; then
  notify "$tv is not connected"
  exit 1
fi

# Enable the TV first so there is never a moment without an output
hyprctl eval "hl.monitor({ output = \"$tv\", mode = \"$tv_mode\", position = \"0x0\", scale = $tv_scale, vrr = 0, bitdepth = 10, disabled = false })" >/dev/null
for name in "${active[@]}"; do
  [[ "$name" == "$tv" ]] && continue
  hyprctl eval "hl.monitor({ output = \"$name\", disabled = true })" >/dev/null
done

hyprctl eval "hl.dispatch(hl.dsp.focus({ monitor = \"$tv\" }))" >/dev/null

# Keep only on an explicit confirmation, anything else (timeout, Esc, close) reverts
rc=0
yad --title="TV mode" \
    --text="Keep this display configuration?\nReverting in ${timeout} seconds." \
    --text-align=center \
    --button="Keep:0" \
    --button="Revert:1" \
    --timeout="$timeout" \
    --timeout-indicator=top \
    --center || rc=$?

if [[ "$rc" -ne 0 ]]; then
  revert
fi
