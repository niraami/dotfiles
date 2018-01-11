#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

if [ $# -eq 0 ]; then
  data="$( lsblk -fPn )";

fi;
