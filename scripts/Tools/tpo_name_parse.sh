#!/usr/bin/env bash

man="Usage: [command] [folder]";

dbg="DEBUG:"
  
err1="process killed";
err2="missing arguments";

trap "echo Error 1: $err1;" EXIT;

#Function definitions:
#

if [ -z "$1" ] || [ ! -d "$1" ]; then
  echo "Error 2: $err2";
  exit 2;
fi;

file_n=0;
file_e_n=0;

errors="";

for File in "$1"*.stp; do
  filename="$(echo "$File" | awk -F'.stp' '{print $1}')";
  name="$(grep TraceParts.PartTitle "$filename".txt | awk -F';' '{print $2}' | sed 's/"//g' | awk -F',' '{print $1}')";
  name="$(echo "$name" | tr '/' 'x')";
  
  rm "$filename.txt";
  mv "$File" "$1$name.stp";

  if [ $? -gt 0 ] || [ -z "$name" ]; then
    errors+="in $File;
      parsed filename: $filename;
      mod. name: $name;\n"
    ((file_e_n++));
  fi;

  ((file_n++));
done;

echo -e "Succesfully parsed $file_n parts\n";
if [ $file_e_n -gt 0 ]; then
  echo -e "Failed to parse $file_e_n parts, detailed list:\n";
  echo -e "$errors";
fi;

trap - EXIT;
