#!/usr/bin/env bash

MONITOR="eDP-1";
STATUS="$(xrandr | grep "$MONITOR" | awk -F' ' '{print $5}')";

if [ "$STATUS" == "inverted" ]; then 
      xrandr -o 0;
      ##killall matchbox-keyboard;
      xinput set-prop 'ELAN22CA:00 04F3:22CA' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1;
else  xrandr -o 2;
      ##matchbox-keyboard &
      xinput set-prop 'ELAN22CA:00 04F3:22CA' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1;
fi;
