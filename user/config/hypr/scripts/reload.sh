#!/usr/bin/env bash

set -eu -o pipefail

script_dir="$HOME/.config/hypr/scripts"

# Hyprland
hyprctl reload

# Waybar
if [[ $(pgrep waybar) ]]; then
  killall waybar
fi
hyprctl dispatch exec "waybar"

# Sunsetr
hyprctl dispatch exec "sunsetr --reload"

# Wallpaper
"${script_dir}/auto_bg.py" --per-output ~/.wallpapers/Landscape
