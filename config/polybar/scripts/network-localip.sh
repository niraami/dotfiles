#!/usr/bin/env bash
# source: https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/network-localip

local_interface=$(ip route | awk '/^default/{print $NF}')
local_ip=$(ip addr show "$local_interface" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')

echo "$local_ip"
