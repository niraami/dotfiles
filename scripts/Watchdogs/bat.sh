#!/usr/bin/env bash

if ! pidlock -l bat_watch $$; then exit 1; fi;
trap "pidlock -u bat_watch;" EXIT;

if [ ! -d /sys/class/power_supply/BAT1 ]; then exit 127; fi;

boot=true;
laststatus="";
lastcap=100;

while [ true ]; do 
	cap=$(cat /sys/class/power_supply/BAT1/capacity);
	status=$(cat /sys/class/power_supply/BAT1/status);
	
	if [[ "$boot" = false && ! "$status" == "$laststatus" && "$status" == "Charging" ]]; then
		notify-send -a "Battery Watchdog" -t 2000 -u low "Charging" "Battery now charging";
		laststatus=$status;
	fi;

	if [[ "$boot" = false && ! "$cap" == "$lastcap" ]]; then
		if [ $cap -lt 30 ]; then
			notify-send -a "Battery Watchdog" -t 5000 -u critical "LowCap" "Battery below 30%"
		elif [ $cap -lt 15 ]; then
			notify-send -a "Battery Watchdog" -t 0 -u critical "WarCap" "Battery below 15%";
		fi;
		lastcap=$cap;
	fi;
	
	if [ "$boot" = true ]; then boot=false; laststatus=$status; lastcap=$cap; fi;
	sleep 5;
done;
