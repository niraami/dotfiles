#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

Opts=();
Opts+=("Adapters");
Opts+=("Daemon_Manager");
Opts+=("Files");
Opts+=("Tools");
Opts+=("Settings");
Opts+=("Mountpoints");
Opts+=("Power");

if [ $# -eq 0 ]; then
  printf "%s\n" "${Opts[@]}";

elif [[ "${Opts[@]}" =~ "$1" ]]; then
  sh "$( find "$THIS"/Advanced/"$1" -iname _*.sh )" > /dev/null &

else
  $0;

fi;
