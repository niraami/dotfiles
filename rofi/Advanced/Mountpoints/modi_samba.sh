#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

if [ $# -eq 0 ]; then
  systemctl list-unit-files --state=enabled |
    awk -F' ' '{print $1}' |
      tail -n +2 |
        head -n -2 |
          sort;
fi;
