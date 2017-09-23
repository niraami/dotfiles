#!/usr/bin/env bash

status=$(setxkbmap -query | grep layout | awk -F ' ' '{print $2}')

if [ "$status" == "us" ]; then
	setxkbmap sk qwerty;	
else
	setxkbmap us;
fi;

