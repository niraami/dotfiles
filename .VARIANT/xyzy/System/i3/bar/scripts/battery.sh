#!/usr/bin/env bash
cd "${0%/*}";

if [ ! -d /sys/class/power_supply/BAT0 ]; then exit; fi;

output=$(cat /sys/class/power_supply/BAT0/capacity);
outStatus=$(cat /sys/class/power_supply/BAT0/status);
outColor="#BAF2F8";

if [ $outStatus == "Charging" ]; then 
	outColor="#258025";
elif [ $output -lt 15 ]; then
	outColor="#B62929";
elif [ $output -lt 30 ]; then
	outColor="#EA4E29";
elif [ $output -lt 50 ]; then
	outColor="#EE6B62";
fi;

echo -e "{" \
	"\"separator_block_width\":12," \
	"\"color\":\"$outColor\"," \
	"\"full_text\":\"$output%\"}";

