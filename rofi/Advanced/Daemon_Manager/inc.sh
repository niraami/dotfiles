#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";
STATEFILE="/tmp/rofiscript.state";
STATE="$(cat $STATEFILE)";


if [ $(systemctl status "$1" | wc -l) -gt 0 ]; then
  echo "$1" > "$STATEFILE";

  Opts+=("$(if [ "$(systemctl is-enabled "$1")" == "enabled" ]; then
    echo "Disable"; else echo "Enable"; fi)");
  Opts+=("$(if [ "$(systemctl is-active "$1")" == "active" ]; then
    echo "Stop"; else echo "Start"; fi)");

  printf "%s\n" "Details" "${Opts[@]}";
  
elif [[ "Details Enable Disable Start Stop" =~ "$1" ]]; then
  #Ask for sudo if needed first
  if sudo -n true 2>/dev/null; then
    pass="";
  else
    pass="$(gksudo  -m "Please enter your password to $action $service" -p)";
  fi;

  case "$1" in
    "Details")
      notify-send -a "Daemon Manager" "$1" "Not implemented yet";
      ;;
    "Enable")
      notify-send -a "Daemon Manager" "$1" "$(echo "$pass" | sudo -S systemctl enable $STATE)";
      ;;
    "Disable")
      notify-send -a "Daemon Manager" "$1" "$(echo "$pass" | sudo -S systemctl disable $STATE)";
      ;;
    "Start")
      notify-send -a "Daemon Manager" "$1" "Starting $STATE";
      echo "$pass" | sudo -S systemctl start $STATE &
      ;;
    "Stop")
      notify-send -a "Daemon Manager" "$1" "Stopped $STATE";
      echo "$pass" | sudo -S systemctl stop $STATE &
      ;;
  esac;

  $0 $STATE;

fi;

