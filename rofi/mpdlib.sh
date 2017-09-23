#!/usr/bin/env bash
#mpdlib.sh | 06.04.2017

#Config
IFS=$'\n'
music_dir="/media/Foxi/Data/Music/";
config="/config/rofi/config.cfg";

#Check config
if [ $# -ne 0 ]; then music_dir="$1"; fi;
if [ ! -d "$music_dir" ]; then exit 1; fi;

#Init Arrays
lib_dir="$(find "$music_dir" -mindepth 1 -maxdepth 1 \( -type d -o -type l \) | sort)";
lib_file="$(find "$music_dir" -maxdepth 1 ! \( -type d -o -type l \) | sort)";

#Concatenate and bashify arrays
lib_all=("$lib_dir"$'\n'"$lib_file");
for Entry in $lib_all; do
  lib+=($(printf "%q" "$Entry"));
done;

#Create array of filenames, not paths
for Entry in ${lib[@]}; do
  lib_fn+=($(basename "$Entry"));
done;

#echo "DEBUG:"
#echo ${lib[@]};
#echo ${lib_fn[@]};
#exit;

#Get user feedback
out="$(printf '%s\n' "${lib_fn[@]}" | rofi -dmenu -config "$config")"
if [ "$?" -eq 1 ]; then exit 1; fi;
#out=".stfolder";

#Associate user feedback with a path
for Entry in ${lib[@]}; do
  if [[ "$Entry" ==  *"$out"* ]]; then out="$Entry"; fi;
done;

echo $(file -bk --mime $out);

if [ -d "$out" ]; then
  "${BASH_SOURCE[0]}" "$out";
elif [[ $(file -bk --mime $out) = *audio* ]]; then
  echo "Audio File!";
else
  "${BASH_SOURCE[0]}" "$1";
fi;
