#!/usr/bin/env bash

# Rofi script for a minimalistic power/system menu

ACCENT="#7e57c2"

BACKGROUND="#141618"
BACKGROUND_ALT="#252525"

FOREGROUND="#a9abb0"

HIGHLIGHT_FOREGROUND="#ffffff"
HIGHLIGHT_BACKGROUND="$ACCENT"

SEPARATOR="$BACKGROUND"
BORDER="$BACKGROUND"

# Launch Rofi
MENU="$(rofi -no-lazy-grab -sep "|" -dmenu -i -p 'System :' \
-hide-scrollbar true \
-bw 0 \
-lines 4 \
-line-padding 10 \
-padding 20 \
-width 15 \
-xoffset -27 -yoffset 60 \
-location 3 \
-columns 1 \
-font "Material Design Icons 10, Fantasque Sans Mono 10" \
-color-window "$BACKGROUND,$BORDER,$SEPARATOR" \
-color-normal "$BACKGROUND_ALT,$FOREGROUND,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
-color-active "$BACKGROUND,$ACCENT,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
-color-urgent "$BACKGROUND,$ACCENT,$BACKGROUND_ALT,$HIGHLIGHT_BACKGROUND,$HIGHLIGHT_FOREGROUND" \
<<< "󰍁 Lock|󰍃 Logout|󰜉 Reboot|󰐥 Shutdown")"
case "$MENU" in
  *Lock) sflock -h -b "$(uname -n | cut -d"-" -f1)" -c "0@$%#&.^*5|%@#" ;;
  *Logout) i3-msg exit ;;
  *Reboot) systemctl reboot ;;
  *Shutdown) systemctl -i poweroff
esac

# Theming help
# color window = background, border, separator
# color normal = background, foreground, background-alt, highlight-background, highlight-foreground
# color active = background, foreground, background-alt, highlight-background, highlight-foreground
# color urgent = background, foreground, background-alt, highlight-background, highlight-foreground
