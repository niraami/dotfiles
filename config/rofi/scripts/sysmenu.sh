#!/usr/bin/env bash

# Rofi script for a minimalistic power/system menu

MENU="$(rofi -no-lazy-grab -sep "|" -dmenu -i -p 'System ::' \
  -config ~/.config/rofi/sysmenu.rasi \
  <<< "󰍁 Lock|󰍃 Logout|󰜉 Reboot|󰐥 Shutdown")"
case "$MENU" in
  *Lock) sflock -h -b "$(uname -n | cut -d"-" -f1)" -c "$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -16)" ;;
  *Logout) i3-msg exit ;;
  *Reboot) systemctl reboot ;;
  *Shutdown) systemctl -i poweroff
esac
