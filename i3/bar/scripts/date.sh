#!/usr/bin/env bash
cd "${0%/*}";

echo -e	"{" \
	"\"name\":\"clock\"," \
	"\"separator\":false," \
	"\"separator_block_width\":0," \
	"\"full_text\":\"$(date +"%A %d.%m") - \"}";

