#!/usr/bin/env bash

# Toggle between the normal multi-monitor layout and HDMI (TV) only.
#
# The normal layout is snapshotted from the live monitors before switching and
# restored from that snapshot, instead of a `hyprctl reload`: a reload disables
# the TV (the only active output) before bringing the others back, and that
# crashes Hyprland every now and then.
#
# To never end up with zero outputs, or with overlapping ones, the TV is parked
# above the other monitors (like it used to be in the config) while it shares the
# layout with them.

set -eu -o pipefail

tv="HDMI-A-1"
tv_width=3840
tv_height=2160
tv_refresh=120
tv_scale=2
timeout=30

state="${XDG_RUNTIME_DIR:-/tmp}/tv_mode.state"

notify() {
  notify-send -a "TV mode" "TV mode" "$1"
}

lua() {
  hyprctl eval "$1" >/dev/null
}

# tv_rule <position> | disable
tv_rule() {
  if [[ "$1" == "disable" ]]; then
    lua "hl.monitor({ output = \"$tv\", disabled = true })"
  else
    lua "hl.monitor({ output = \"$tv\", mode = \"${tv_width}x${tv_height}@${tv_refresh}\", position = \"$1\", scale = $tv_scale, vrr = 0, bitdepth = 10, disabled = false })"
  fi
}

# Position for the TV right above the layout described by a monitors JSON array
# on stdin, horizontally centered on it
park_position() {
  jq -r --argjson w "$((tv_width / tv_scale))" --argjson h "$((tv_height / tv_scale))" '
    (map(.x) | min) as $left
    | (map(.x + (.width / .scale)) | max) as $right
    | (map(.y) | min) as $top
    | "\((($left + $right) / 2 - $w / 2) | round)x\($top - $h | round)"'
}

snapshot_rules() {
  jq -r '.[] | "hl.monitor({ output = \"\(.name)\", mode = \"\(.width)x\(.height)@\((.refreshRate * 100 | round) / 100)\", position = \"\(.x)x\(.y)\", scale = \(.scale), transform = \(.transform), vrr = \(if .vrr then 1 else 0 end), bitdepth = \(if (.currentFormat | test("2101010")) then 10 else 8 end), disabled = false })"' "$state"
}

revert() {
  if [[ ! -s "$state" ]]; then
    # No snapshot (e.g. the session was restarted), fall back to the config
    hyprctl reload >/dev/null
    return
  fi

  tv_rule "$(park_position < "$state")"
  while IFS= read -r rule; do
    lua "$rule"
  done < <(snapshot_rules)
  tv_rule disable
  rm -f "$state"
}

# Ignore repeated presses while the confirmation dialog is open
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/tv_mode.lock"
flock -n 9 || exit 0

monitors="$(hyprctl monitors -j)"
mapfile -t active < <(jq -r '.[].name' <<< "$monitors")

if [[ "${#active[@]}" -eq 1 && "${active[0]}" == "$tv" ]]; then
  revert
  exit 0
fi

if ! hyprctl monitors all -j | jq -e --arg tv "$tv" 'any(.[]; .name == $tv)' >/dev/null; then
  notify "$tv is not connected"
  exit 1
fi

echo "$monitors" > "$state"

# Enable the TV first so there is never a moment without an output
tv_rule "$(park_position <<< "$monitors")"
for name in "${active[@]}"; do
  [[ "$name" == "$tv" ]] && continue
  lua "hl.monitor({ output = \"$name\", disabled = true })"
done
tv_rule "0x0"
lua "hl.dispatch(hl.dsp.focus({ monitor = \"$tv\" }))"

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
