#!/usr/bin/env bash
# source: https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/network-localip
# source: https://unix.stackexchange.com/questions/14961/how-to-find-out-which-interface-am-i-using-for-connecting-to-the-internet

local_interface=$(ip route get 8.8.8.8 | grep -Po '(?<= dev ).+?(?= (src|proto))')
local_ip=$(ip addr show "$local_interface" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')

echo "$local_ip"
