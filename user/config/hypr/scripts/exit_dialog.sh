#!/usr/bin/env bash

# Display the dialog with yad and store the result in the variable 'response'
response=$(yad --title="Confirmation" \
               --text="Exit Hyprland?" \
               --text-align=center \
               --button="Yes:1" \
               --button="No:0" \
               --timeout=10 \
               --timeout-indicator=top \
               --center)

# Check the response and execute the command if necessary
if [ $? -eq 1 -o $? -eq 70 -o $? -eq 255 ]; then
    hyprctl dispatch exit 0
fi
