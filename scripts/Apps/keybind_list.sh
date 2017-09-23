#!/usr/bin/env bash

lines="$(cat /config/i3/config | grep bindsym | awk -Fbindsym '{print }')"

echo -e "$lines";
