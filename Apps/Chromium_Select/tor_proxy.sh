#!/usr/bin/env bash
#PRIORITY 8

dir="/tmp/chromium_tor/";
if [ ! -d "$dir" ]; then mkdir "$dir"; fi;

chromium --incognito --user-data-dir="$dir" --proxy-server="socks5://127.0.0.1:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE myproxy";
