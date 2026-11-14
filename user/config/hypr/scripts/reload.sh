#!/usr/bin/env bash

set -eu -o pipefail

script_dir="$HOME/.config/hypr/scripts"

# Hyprland
hyprctl reload

# Waybar, wait for the old instance to exit before starting a new one
killall -qw waybar || true
hyprctl dispatch 'hl.dsp.exec_cmd("waybar")'

# Sunsetr
hyprctl dispatch 'hl.dsp.exec_cmd("sunsetr --reload")'

# Wallpaper
"${script_dir}/auto_bg.py" --per-output "${WALLPAPER_DIR:-$HOME/.wallpapers/Landscape}"
