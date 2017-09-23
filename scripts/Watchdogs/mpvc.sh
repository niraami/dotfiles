#!/usr/bin/env bash

if ! pidlock -l mpvc_watch $$; then exit 1; fi;
trap "pidlock -u mpvc_watch;" EXIT;

boot=true;

while [ true ]; do
	song=$(mpvc --format "%title%");
	status=$(mpvc --format "%status%");
  echo "$status";

	if [[ ! "$status" == "$laststatus" || ! "$song" == "$lastsong" ]] && [ "$boot" = false ]; then
		if [ "$status" == "playing" ]; then
			notify-send -a "MPVC Watchdog" -u low "Playing" "$song";
		elif [ "$status" == "paused" ]; then 
			notify-send -a "MPVC Watchdog" -u low "Pause" "Music Playback Paused";
		else
			notify-send -a "MPVC Watchdog" -u low "Stop" "Music Playback Stopped";
		fi;

		#echo "Sent";
	fi;
	
	lastsong=$song;
	laststatus=$status;

	if [ "$boot" = true ]; then boot=false; fi;
	sleep 1;
done;
