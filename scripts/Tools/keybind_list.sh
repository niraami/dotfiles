#!/usr/bin/env bash

lines="$(cat /.config/System/i3/config | grep bindsym | awk -Fbindsym '{print }')"

echo -e "$lines";
