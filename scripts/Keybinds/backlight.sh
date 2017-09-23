#!/usr/bin/env bash

if [ $# == 0 ]; then echo "Err: No arguments entered"; exit; fi;

maxLevel=$(cat /sys/class/backlight/intel_backlight/max_brightness);
curLevel=$(cat /sys/class/backlight/intel_backlight/brightness);

newLevel=$(echo "scale=2; ($curLevel+($1*($maxLevel/100)))" | bc); newLevel=$(echo "$newLevel/1" | bc);

if [ $newLevel -lt 38 ]; then newLevel=38; fi;
if [ $newLevel -gt $maxLevel ]; then newLevel=$maxLevel; fi;
sudo tee /sys/class/backlight/intel_backlight/brightness <<< $newLevel;


