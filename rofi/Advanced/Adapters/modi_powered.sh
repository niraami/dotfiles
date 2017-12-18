#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";
source "$THIS/inc.sh";

if [ $# -eq 0 ]; then
  for ((i=0; i<$n_adapter; i++)); do
    if [[ ${power[$i]} == "True" ]]; then
      c_type+=("${type[$i]}");
      c_power+=("$( if [[ ${power[$i]} == "True" ]]; then
        echo "$fgg"ON"$fgg_";  else  echo "$fgr"OFF"$fgr_"; fi)");
      c_conn+=("$( if [[ ${conn[$i]} == "True" ]]; then
        echo "$fgg"Online"$fgg_";  else  echo "$fgr"Offline"$fgr_"; fi)");
      c_teth+=("$( if [[ ${teth[$i]} == "True" ]]; then
        echo "$fgg"Tethering"$fgg_"; fi)");
    fi;
  done;

  out="";
  for ((i=0; i<${#c_type[@]}; i++)); do
    out+="${c_type[$i]}^^${c_power[$i]}^${c_conn[$i]}^${c_teth[$i]}\n";
  done;

  echo "$( echo -e "$out" | column -s\^ -t )";
fi;
