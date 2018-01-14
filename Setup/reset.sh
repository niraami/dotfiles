#!/usr/bin/env bash
# areuz - 12.01.2018

#CONFIG FOLDER
if [ "$#" -eq 0 ]; then 
  CONFIG="\\"; 
else
  CONFIG="$1";
fi;
while [[ ! -d "$CONFIG" || ! -d "$CONFIG/.VARIANT" ]]; do
  clear;
  echo -e "Enter your config directory path: ";
  echo -en "\n> ";

  read -e CONFIG;
done;


#Switch to config root
cd "$CONFIG";

#Symlink .VARIANT files
CHANGE_LIST=();
for FILE in $( find "$CONFIG/.VARIANT/" "$CONFIG/.PRIVATE/" ! -path *".git"* ); do
  #Remove extra slashes
  FILE="$(readlink -m "$FILE")";

  DIR="$(dirname $FILE | cut -d "/" -f 5-)";
  DEST="./$DIR/$( basename $FILE )";

  #Remove only if it's a link
  if [ -L "$DEST" ]; then
    CHANGE_LIST+="$(rm -fv "$DEST")\n";
  fi;
done;

#Print all changes
echo -e $CHANGE_LIST;

