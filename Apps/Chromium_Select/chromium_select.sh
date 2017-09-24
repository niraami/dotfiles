#!/usr/bin/env bash
cd /.config/Apps/Chromium_Select/;

files=($(find -mindepth 1 -type f ! -name "chromium_select.sh" -name "*.sh"));
count=$(echo ${#files[@]});
data="";

#Sorting $files by 'PRIORITY' tag inside the file
for Entry in ${files[@]}; do
  priority="$(head -n 3 $Entry | grep "#PRIORITY" | awk '{print $2}')";
  if [[ $priority =~ ^[0-9]+$ ]]; then files_sorted[$priority]="$Entry"; fi;
done;

for File in ${files_sorted[@]}; do
  mode_name="$(basename $File | awk -F'.' '{print $1}')";
  data+="$File $mode_name off ";
done;

out="$(Xdialog --stdout --title "Chromium Select Menu" --center --no-tags\
  --radiolist "Modes:" $(($count*6)) 60 $count $data)";

if [ $? -eq 1 ]; then exit 1; fi;

$("$out") &
