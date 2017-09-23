#!/usr/bin/env bash

MONITOR="eDP-1";
STATUS="$(xrandr | grep "$MONITOR" | awk -F' ' '{print $5}')";

if [ "$STATUS" == "inverted" ]; then 
      xrandr -o 0;
      killall matchbox-keyboard;
else  xrandr -o 2;
      matchbox-keyboard &
fi;
