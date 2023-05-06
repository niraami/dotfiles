#!/usr/bin/env bash

COLOR="$(hyprpicker --autocopy --no-fancy --render-inactive)"

notify-send "Color Picker" "$COLOR"
