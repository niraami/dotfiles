#!/usr/bin/env bash
cd "${0%/*}";

output=$(timeout 0.2 /.config/scripts/online.sh); 
if [ "$output" == true ]; then output=$(hostname -i | rev | cut -c 2- | rev); fi;

outColor="#BAF2F8";

if [[ "$output" == "127.0.0.2" || "$output" = false || "$output" == "" ]]; then
	output="Unreachable";
	outColor="#B62929";
fi;

echo -e "{" \
	"\"separator_block_width\":24," \
	"\"color\":\"$outColor\"," \
       	"\"full_text\":\"$output\"}";
