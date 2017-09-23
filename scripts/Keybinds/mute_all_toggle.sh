#!/usr/bin/env bash

sinkcount=$(wc -l <<< $(pactl list sinks | grep "Sink #"));

for i in $(seq 1 $sinkcount); do
	pactl set-sink-mute $[$i-1] toggle;
done;

