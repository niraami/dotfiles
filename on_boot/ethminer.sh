#!/usr/bin/env bash

while true; do
  nvidia-settings -q all > /dev/null;

  while [ $? -eq 1 ]; do
    sleep 5;
    nvidia-settings -q all > /dev/null;
  done;
  
  nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1';
  nvidia-settings -a '[gpu:0]/GPUGraphicsClockOffset[3]=80';
  nvidia-settings -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=1250';
  nvidia-settings -a "[gpu:0]/GPUFanControlState=1";
  nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=60";
  
  ethminer --farm-recheck 200 -U -v 0 -S eu1.ethermine.org:4444 -FS us1.ethermine.org:4444 -O 0x79c628412BC9fB54c17764b11D5D3A24880046Ae.Saiko | tee ~/.log/ethminer.log &
  
  sleep 1800;
  echo -e "\n\n\nRoutine Restarting...\n\n\n";
  pkill ethminer;
done;
