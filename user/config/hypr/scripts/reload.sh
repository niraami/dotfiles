#!/usr/bin/env bash

set -eu -o pipefail

# Hyprland
hyprctl reload

# Waybar
if [[ $(pgrep waybar) ]]; then
  killall waybar
fi
hyprctl dispatch exec waybar

# Sunsetr
hyprctl dispatch sunsetr --reload
