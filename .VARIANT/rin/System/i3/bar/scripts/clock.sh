#!/usr/bin/env bash
cd "${0%/*}";

echo -e "{" \
	"\"name\":\"clock\"," \
	"\"separator_block_width\":24," \
	"\"full_text\":\"$(date +"%H:%M:%S")\"}";
