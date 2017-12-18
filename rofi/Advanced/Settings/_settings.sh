#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

Opts=();


if [ $# -eq 0 ]; then
  printf "%s\n" "${Opts[@]}";

elif [[ "${Opts[@]}" =~ "$1" ]]; then

