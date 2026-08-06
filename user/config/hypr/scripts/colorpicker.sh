#!/usr/bin/env bash

set -eu -o pipefail

COLOR="$(hyprpicker --autocopy --no-fancy --render-inactive)"
notify-send "Color Picker" "$COLOR"
