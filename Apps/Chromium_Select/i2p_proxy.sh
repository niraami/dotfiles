#!/usr/bin/env bash
#PRIORITY 9

dir="/tmp/chromium_i2p/";
if [ ! -d "$dir" ]; then mkdir "$dir"; fi;

chromium http://127.0.0.1:7657/home --incognito --user-data-dir="$dir" --proxy-server=127.0.0.1:4444 --proxy-bypass-list="127.0.0.1";
