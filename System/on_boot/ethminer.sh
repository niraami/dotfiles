#!/usr/bin/env bash

nvidia-settings -q all > /dev/null;

while [ $? -eq 1 ]; do
  sleep 5;
  nvidia-settings -q all > /dev/null;
done;
  
export GPU_FORCE_64BIT_PTR=0;
export GPU_MAX_HEAP_SIZE=100;
export GPU_USE_SYNC_OBJECTS=1;
export GPU_MAX_ALLOC_PERCENT=100;
export GPU_SINGLE_ALLOC_PERCENT=100;

nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1';
nvidia-settings -a '[gpu:0]/GPUGraphicsClockOffset[3]=70';
nvidia-settings -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=1100';
nvidia-settings -a "[gpu:0]/GPUFanControlState=1";
nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=60";
  
ethminer --farm-recheck 200 -U -RH -v 0 -S eu1.ethermine.org:14444 -FS us1.ethermine.org:14444 -O 0x6489312EE73FF530C9deD9500F14f7cfec5451BE.Saiko;
