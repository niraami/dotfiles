#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

incognito_dir="/tmp/chromium_incognito/";
tor_dir="/tmp/chromium_tor/";
i2p_dir="/tmp/chromium_i2p/";

Opts=();
Opts+=("Normal");
Opts+=("Incognito");
Opts+=("Tor");
Opts+=("i2p");

if [ $# -eq 0 ]; then
  printf "%s\n" "${Opts[@]}";

elif [[ "${Opts[@]}" =~ "$1" ]]; then
  case "$1" in
    "Normal")
      google-chrome-stable > /dev/null 2>&1 &
      ;;

    "Incognito")
      if [ -d "$incognito_dir" ]; then rm -rf "$incognito_dir"; fi;
      mkdir "$incognito_dir";

      google-chrome-stable --incognito --user-data-dir="$incognito_dir" > /dev/null 2>&1 &
      ;;

    "Tor")
      if [ -d "$tor_dir" ]; then rm -rf "$tor_dir"; fi;
      mkdir "$tor_dir";

      google-chrome-stable --incognito \
        --user-data-dir="$tor_dir" \
        --proxy-server="socks5://127.0.0.1:9050" \
        --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE myproxy" > /dev/null 2>&1 &
      ;;

    "i2p")
      if [ -d "$i2p_dir" ]; then rm -rf "$i2p_dir"; fi;
      mkdir "$i2p_dir";

      google-chrome-stable http://127.0.0.1:7657/home --incognito \
        --user-data-dir="$i2p_dir" \
        --proxy-server=127.0.0.1:4444 \
        --proxy-bypass-list="127.0.0.1" > /dev/null 2>&1 &
      ;;
  esac;

else
  $0;

fi;
