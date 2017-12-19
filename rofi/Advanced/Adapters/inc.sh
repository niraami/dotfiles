#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";
STATEFILE="/tmp/rofiscript.state";
STATE="$(cat $STATEFILE)";

mapfile -t raw < <(connmanctl technologies);

name=($(printf "%s\n" "${raw[@]}" | grep Name | awk -F' ' '{print $3}'));
type=($(printf "%s\n" "${raw[@]}" | grep Type | awk -F' ' '{print $3}'));
power=($(printf "%s\n" "${raw[@]}" | grep Powered | awk -F' ' '{print $3}'));
conn=($(printf "%s\n" "${raw[@]}" | grep Connected | awk -F' ' '{print $3}'));
teth=($(printf "%s\n" "${raw[@]}" | grep Tethering | awk -F' ' '{print $3}'));
n_adapter=${#name[@]};

Opts=("Enable Disable Connect");

fgg="<span foreground=\"green\">";
fgg_="</span>";
fgr="<span foreground=\"blue\">";
fgr_="</span>";

#Until a pango parser is implemented
fgg="";
fgg_="";
fgr="";
fgr_="";

if [ $# -eq 0 ]; then
  test;

elif [[ "${type[@]}" =~ $( echo "$1" | cut -d" " -f 1) ]]; then
  id="$( echo "$1" | cut -d" " -f 1)";
  echo "$id" > "$STATEFILE";

  Opts=();

  for ((i=0; i<$n_adapter; i++)); do
    if [[ "$id" == "${type[$i]}" ]]; then
      Opts+=( $( if [[ "${power[$i]}" == "True" ]]; then
        echo "Disable"; else echo "Enable";  fi; ) 
      );
      Opts+=("Connect");
      break;
    fi;
  done;

  printf "%s\n" "${Opts[@]}";

elif [[ "${Opts[@]}" =~ "$1" ]]; then
  case "$1" in
    "Enable")
      notify-send -a "Adapter Manager" "Enabling $STATE" "$(connmanctl enable "$STATE")";
      ;;
    "Disable")
      notify-send -a "Adapter Manager" "Disabling $STATE" "$(connmanctl disable "$STATE")";
      ;;
    "Connect")
      notify-send -u normal -a "Adapter Manager" "error" "Not implemented yet";
      ;;
  esac;

  $0;

else
  $0;

fi;
