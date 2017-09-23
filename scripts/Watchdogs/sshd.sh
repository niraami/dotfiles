#!/usr/bin/env bash

if ! pidlock -l sshd_watch $$; then exit 1; fi;
trap "pidlock -u sshd_watch;" EXIT;

LOG=/tmp/sshd.fifo;
if [ ! -p $LOG ]; then mkfifo $LOG; fi;
systemd-cat -t "sshd_watchdog" < $LOG &
exec 3>$LOG;

val="$(who)";
lastval="$val";

function ERRDUMP()
{
  echo -e "DATA DUMP:\nlastval: [$(echo "$lastval" | tr '\n' ' ')]\n\
    val: [$(echo "$val" | tr '\n' ' ')]" >&3;
}

function checkIP()
{
  ping -c 1 -w 2 $1 > /dev/null;
  if [ $? -eq 0 ]; then
    return 0;
  else
    return 1;
    notify-send -a "SSHD Watchdog" -u critical "IP_ERROR" "No response from target IP";
  fi;
}

while [ true ]; do
  val="$(who)";

  if [ ! "$val" = "$lastval" ]; then
    val_l=$(wc -l <<< "$val");
    lastval_l=$(wc -l <<< "$lastval");

    if [ $val_l -gt $lastval_l ]; then
      newval="$(echo "$val" | grep -v -F -x -e "$lastval")"
      newval="$(echo "$newval" | awk -F'[()]' '{print $2}' | sed '/^\s*$/d')";

      for Entry in $newval; do
        if ! checkIP $Entry; then break; fi;
        echo "Client $Entry Connected" >&3;
        notify-send -a "SSHD Watchdog" -u normal "Client_Connected" "$Entry Connected!";
      done;

    elif [ $val_l -lt $lastval_l ]; then
      newval="$(echo "$lastval" | grep -v -F -x -e "$val")"
      newval="$(echo "$newval" | awk -F'[()]' '{print $2}' | sed '/^\s*$/d')";
      
      for Entry in $newval; do
        if ! checkIP $Entry; then break; fi;
        echo "Client $Entry Disconnected" >&3;
        notify-send -a "SSHD Watchdog" -u normal "Client_Disconnected" "$Entry Disconnected!";
      done;

    else
      notify-send -a "SSHD Watchdog" -u critical "Change" "Undefined SSHD change\nDATA DUMPED";
    fi;
  fi;

  lastval="$val";
  sleep 1;
done;
