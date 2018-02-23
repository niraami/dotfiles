#!/usr/bin/env bash
#'scrcap.sh' 05.01.2017 : 13:30

scr_repo="/media/Foxi/Data/Screenshots/"
tmp_file="/tmp/scrcap.png"
sleep 0.1;
scrot -b -q 100 -s -z "$tmp_file"

if [ $? == 2 ]; then exit 2; fi;

num_used=$(find "$scr_repo" -maxdepth 1 -type f | sed 's/[^0-9]*//g');

declare -a used;
for i in ${num_used[@]}; do
  used[$i]=1;
done;

for((unused = 0; used[unused] == 1; ++unused)); do true; done;

unused="screenshot$unused.png";

filename=$(Xdialog --stdout --allow-close --center --title "Screenshot Dialog" \
  --fselect "$scr_repo$unused" 25 100);

#filename=$(Xdialog --stdout --allow-close\
#      --title "Screenshot Dialog" \
#      --center --inputbox "Screenshot Filename:" 12 40 "$unused");

if [ -z "$filename" ]; then
  rm "$tmp_file";
  exit 127;
else 
  mv "$tmp_file" "$filename"; 
  feh -qZd -^ "Screenshot View" --no-recursive $filename &
  sleep 0.1;
  i3-msg '[title="Screenshot View"] floating enable';  
fi;
