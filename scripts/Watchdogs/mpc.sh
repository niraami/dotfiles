#!/usr/bin/env bash

if ! pidlock -l mpc_watch $$; then exit 1; fi;
trap "pidlock -u mpc_watch;" EXIT;

boot=true;

while [ true ]; do
	song=$(mpc current);
	status=$(mpc | sed -n 2p | awk '{printf $1}');

	if [[ ! "$status" == "$laststatus" || ! "$song" == "$lastsong" ]] && [ "$boot" = false ]; then
		if [ "$status" == "[playing]" ]; then
			notify-send -a "MPC Watchdog" -u low "Playing" "$song";
		elif [ "$status" == "[paused]" ]; then 
			notify-send -a "MPC Watchdog" -u low "Pause" "Music Playback Paused";
		else
			notify-send -a "MPC Watchdog" -u low "Stop" "Music Playback Stopped";
		fi;

		#echo "Sent";
	fi;
	
	lastsong=$song;
	laststatus=$status;

	if [ "$boot" = true ]; then boot=false; fi;
	sleep 1;
done;
