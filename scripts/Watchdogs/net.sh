#!/usr/bin/env bash

if ! pidlock -l net_watch $$; then exit 1; fi;
trap "pidlock -u net_watch;" EXIT;

boot=true;
laststatus="";

while [ true ]; do
	
	status=$(timeout 0.5 /config/scripts/online.sh);
	if [ "$status" == "true" ]; then status=$(timeout 1 hostname -i | rev | cut -c 2- | rev); fi;
	if [[ "$status" == "" && $(ping -w 1 -c 1 172.217.21.238) ]]; then status=$laststatus; fi;
			
	if [[ ! "$status" == "$laststatus" && "$boot" = false ]]; then 
		if [[ "$status" == "127.0.0.2" || "$status" == "false" || "$status" == "" ]] &&
		 ! [[ "$laststatus" == "127.0.0.2" || "$laststatus" == "false" || "$laststatus" == "" ]]; then
			notify-send -a "Network Watchdog" -t 7500 -u normal "Disconnect" "All connections terminated";
		elif [[ "$laststatus" == "127.0.0.2" || "$laststatus" == "false" || "$laststatus" == "" ]]; then
			notify-send -a "Network Watchdog" -t 5000 -u low "Connected" "New connection established";
		elif ! [[ "$status" == "127.0.0.2" || "$status" == "false" || "$status" == "" ]]; then
			notify-send -a "Network Watchdog" -t 5000 -u low "Change" "Unknown onnection change";
		fi;
		
		laststatus=$status;
	fi;
	
	if [ "$boot" = true ]; then boot=false; laststatus=$status; fi;
	sleep 2;
done;
