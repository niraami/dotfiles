#!/usr/bin/env bash
cd "${0%/*}";

output=$(echo $(setxkbmap -query | grep layout) | awk -F ': ' '{print toupper($2)}');
echo -e "{" \
	"\"separator_block_width\":24," \
	"\"name\":\"layout\"," \
       	"\"full_text\":\"$output\"}";
