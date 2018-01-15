#!/usr/bin/env bash

while [ $? -eq 1 ]; do
  sleep 5;
  nvidia-settings -q all > /dev/null;
done;

nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1';
nvidia-settings -a '[gpu:0]/GPUGraphicsClockOffset[3]=70';
nvidia-settings -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=1100';
nvidia-settings -a "[gpu:0]/GPUFanControlState=1";
nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=60";
