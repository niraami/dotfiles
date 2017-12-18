#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";


Args=();
Args+=("-dmenu" "-no-custom");
Args+=("-theme" "default");

Opts=();
Opts+=("Shutdown" "Shutdown i3" "Reboot" "Suspend");


if [ $# -eq 0 ]; then
  out="$(printf "%s\n" "${Opts[@]}" | rofi "${Args[@]}")";
fi;

if [[ "${Opts[@]}" =~ "$out" ]]; then
  case "$out" in
    "Shutdown")
      systemctl poweroff;
      ;;
    "Shutdown i3")
      for proc in /tmp/pidlock/*.lock; do
        kill "$(cat $proc)";
      done;
      i3-msg exit;
      ;;
    "Reboot")
      systemctl reboot;
      ;;
    "Suspend")
      systemctl suspend;
      ;;
  esac;

else
  echo "Internal script error";
  exit;

fi;
