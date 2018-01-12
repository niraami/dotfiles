#!/usr/bin/env bash
# areuz - 12.01.2018

#CONFIG FOLDER
CONFIG="\\";
while [[ ! -d "$CONFIG" || ! -d "$CONFIG/.VARIANT" ]]; do
  clear;
  echo -e "Enter your config directory path: ";
  echo -en "\n> ";

  read -e CONFIG;
done;



#VARIANTS
#Switch to .VARIANT folder
cd "$CONFIG/.VARIANT";

VARIANT="\\";
while [[ ! -d "$VARIANT" || "$VARIANT" == "" ]]; do
  clear;
  echo -e "Config dir: $CONFIG\n";

  echo "Choose environment variant:";
  for VAR in ./*; do
    echo -e "  $(basename $VAR)";
  done;
  echo -en "\n> ";

  read -e VARIANT;
done;


#Switch back to config root
cd "$CONFIG";

#Symlink .VARIANT files
CHANGE_LIST=();
for FILE in $(find "$CONFIG/.VARIANT/$VARIANT" -type f -o -type l); do
  #Remove extra slashes
  FILE="$(readlink -m "$FILE")";

  DIR="$(dirname $FILE | cut -d "/" -f 5-)";
  DEST="./$DIR/$( basename $FILE )";

  CHANGE_LIST+="$(rm -fv "$DEST")\n";
done;

#Print all changes
echo -e "$( echo -e $CHANGE_LIST | column -s '>' -t -o '' )";

#Pause so the user can read it
echo -en "\nPress any key to continue...\n\n> ";
read -N 1;

