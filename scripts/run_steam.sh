#!/usr/bin/env bash

#Fixes steam not starting (ssfn*)

if [ "$1" == "--fix" ]; then
	find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete;
fi;

vblank_mode=0 primusrun steam;
