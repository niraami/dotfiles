#!/usr/bin/env bash
#PRIORITY 6

HASH="9a95da2507d57ff83bb1e13597dcf0dec6dd323f6a88c63ae2e4fc7aaaec6c87866c2866076eb2a14bf63b7ccfe7cef00b9f988ac5e767c77826dab410790dc9";

out="$(Xdialog --stdout --title "Identity_Check" --center --password \
  --inputbox "Password" 10 37)";

if [ $? -eq 1 ]; then exit 1; fi;

out="$(echo -n "$out" | sha512sum | awk '{print $1}')";
if ! [ $out = $HASH ]; then exit 1; fi;
#DECRYPT VAULT FOLDER"

dir="/media/Foxi/Vault/Second_Identity/chromium/";
if [ ! -d "$dir" ]; then mkdir "$dir"; fi;

chromium --user-data-dir="$dir" --proxy-server="socks5://127.0.0.1:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE myproxy";
