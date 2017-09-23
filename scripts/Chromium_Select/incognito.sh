#!/usr/bin/env bash
#PRIORITY 7

dir="/tmp/chromium_incognito/";
if [ -d "$dir" ]; then rm -r "$dir"; fi;
mkdir "$dir";

chromium --incognito --user-data-dir="$dir";
