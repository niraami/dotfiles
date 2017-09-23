#!/usr/bin/env bash

if [ -z "$1" ]; then CWD="$PWD";
else CWD="$1/";
fi;

out_dir=""$CWD"/Extracted/";
if [ ! -d "$out_dir" ]; then mkdir "$out_dir"; fi;

function mkdir_() {
  if [ -z "$1" ]; then return; fi;
  iterator=0;
  newdir=""$out_dir"/$(basename $1 | awk -F '.' '{print $1}')"
  newdir_="$newdir";
  while [ -d "$newdir_" ]; do
    newdir_=""$newdir"_$iterator";
    ((iterator++));
  done;

  mkdir "$newdir_";
  echo "$newdir_";
}

OLDIFS="$IFS";
IFS=$(echo -en "\n\b")

for _Rar in $(find "$CWD" -maxdepth 1 -type f -iname "*.rar"); do
  cd "$(mkdir_ "$_Rar")";
  rar x -or "$_Rar" 2>> "$CWD/.uncomp_errors";
done;

for _Zip in $(find "$CWD" -maxdepth 1 -type f -iname "*.zip"); do
  cd "$(mkdir_ "$_Zip")";
  unzip -j "$_Zip" 2>> "$CWD/.uncomp_errors";
done;

for _7Z  in $(find "$CWD" -maxdepth 1 -type f -iname "*.7z"); do
  cd "$(mkdir_ "$_7Z")";
  7za x \""$_7Z"\" 2>> "$CWD/.uncomp_errors";
done;

if [ ! -s "$CWD/.uncomp_errors" ]; then rm "$CWD/.uncomp_errors"; fi;

IFS="$OLDIFS";
