#!/usr/bin/env bash
source ~/.config/env_config/.display;
THIS="$( cd "$(dirname "$0")"; pwd -P )";

Opts=();


if [ $# -eq 0 ]; then
	pcmanfm /media &
  #printf "%s\n" "${Opts[@]}";

elif [[ "${Opts[@]}" =~ "$1" ]]; then
	pcmanfm /media &
fi;
