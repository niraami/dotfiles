#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";
source "$THIS/inc.sh";

if [ $# -eq 0 ]; then
  for ((i=0; i<$n_adapter; i++)); do
    c_power="$( if [[ ${power[$i]} == "True" ]]; then
      echo "$fgg"ON"$fgg_";  else  echo "$fgr"OFF"$fgr_"; fi)";
    c_conn="$( if [[ ${conn[$i]} == "True" ]]; then
      echo "$fgg"Online"$fgg_";  else  echo "$fgr"OFF"$fgr_"; fi)";
    c_teth="$( if [[ ${teth[$i]} == "True" ]]; then
      echo "$fgg"Tethering"$fgg_";  else  echo "$fgr"OFF"$fgr_"; fi)";

    echo "${type[$i]}^^^$c_power^$c_conn^$c_teth" | column -s\^ -t;
  done;
fi;
