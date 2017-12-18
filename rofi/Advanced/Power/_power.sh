#!/usr/bin/env bash
source ~/.config/env_config/.display;
THIS="$( cd "$(dirname "$0")"; pwd -P )";


Args=();
Args+=("-dpi" "$DPI"); 
Args+=("-dmenu" "-no-custom");
Args+=("-theme" "default");
Args+=("-p" "Action:");

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
  $0;

fi;
