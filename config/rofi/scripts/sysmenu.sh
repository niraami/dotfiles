#!/usr/bin/env bash

# Rofi script for a minimalistic power/system menu

MENU="$(rofi -no-lazy-grab -sep "|" -dmenu -i -p 'System ::' \
  -config ~/.config/rofi/sysmenu.rasi \
  <<< "󰍁 Lock|󰍃 Logout|󰖳 Windows|󰜉 Reboot|󰐥 Shutdown")"
case "$MENU" in
  *Lock) dm-tool lock ;;
  *Logout) i3-msg exit ;;
  *Windows) virsh -c qemu:///system start Win11-passthrough ;;
  *Reboot) systemctl reboot ;;
  *Shutdown) systemctl -i poweroff
esac
