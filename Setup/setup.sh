#!/usr/bin/env bash
# areuz - 12.01.2018

#USERNAME
USER="";
while [[ ! "$USER" =~ "$(users)" || "$USER" == "" ]]; do
  clear;
  echo "Select your username:";
  echo -e "  $(users | tr " " "\n  ")";
  echo -en "\n> ";

  read USER;
done;



#CONFIG FOLDER
CONFIG="\\";
while [[ ! -d "$CONFIG" || ! -d "$CONFIG/.VARIANT" ]]; do
  clear;
  echo -e "User: $USER\n";

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
  echo -e "User: $USER\nConfig dir: $CONFIG\n";

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
  FILE="$(realpath -s "$FILE")";

  DIR="$(dirname $FILE | cut -d "/" -f 5-)";
  
  if [ ! -d $DIR ]; then
    mkdir -p $DIR;
  fi;
 
  DEST="./$DIR/$( basename $FILE )";

  #If this path=file & exists
  if [ "$( stat "$DEST" 2> /dev/null )" != "" ]; then
    CHANGE_LIST+="Replacing... ";
    rm -f "$DEST";
  fi;

  CHANGE_LIST+="$(ln -vs "$FILE" "$DEST")\n";
done;

#Print all changes
echo -e "$( echo -e $CHANGE_LIST | column -s '>' -t -o '' )";

#Pause so the user can read it
echo -en "\nPress any key to continue...\n\n> ";
read -N 1;



#DEPENDENCIES
DEPS="";
OPT=(none core all);
OPT_=(none core all); 
while [[ ${OPT[@]} == ${OPT_[@]} ]]; do
  clear;
  echo -e "User: $USER\nConfig dir: $CONFIG\nVariant: $VARIANT\n";

  echo -en "Do you want to install packages? [none/core/all]\n\n> "
  
  read DEPS;
  if [ "$DEPS" == "" ]; then
    DEPS="none";
  fi;
  
  OPT_=(${OPT[@]/$DEPS/});
done;

#Install dependencies
if [ "$DEPS" != "none" ]; then
  sudo -u "$USER" yaourt -S Setup/.dependencies.pac --needed --noconfirm;

  if [ "$DEPS" == "all" ]; then
    for PAC_LIST in $(find "Setup" -name ".*.pac" ! -name ".dependencies.pac" ); do
      echo -e "\nDo you want to install this package list? [y/n]\n"\
        "[$(basename $PAC_LIST | cut -c 2-)]\n\nPackages:";
      cat "$PAC_LIST";
      echo -en "\n> "

      while [[ "$CONFIRM" != "y" && "$CONFIRM" != "n" ]]; do
        read -N 1 CONFIRM;
      done;
      
      if [ "$CONFIRM" == "y" ]; then
        sudo -u "$USER" yaourt -S $PAC_LIST --needed;
      fi;

      CONFIRM="";
    done;
  fi;
fi;



#INSTALLING FILES
INSTALL="";
while [[ "$INSTALL" != "y" && "$INSTALL" != "n" ]]; do
  clear;
  echo -e "User: $USER\nConfig dir: $CONFIG\nVariant: $VARIANT\n";
  
  echo -en "Link files into system directories? [y/n]\n\n> "

  read -N 1 INSTALL;
done;

#Link files via ./locations file
if [ "$INSTALL" == "y" ]; then
  CHANGE_LIST=();
  HOME="$(eval echo "~$USER")";

  readarray -d $'\n' -t src < <(grep -v '#' .locations | grep '>' | cut -f1 -d '>');
  readarray -d $'\n' -t dsc < <(grep -v '#' .locations | grep '>' | cut -f2 -d '>' | cut -c 2-);

  for ((i=0; i<${#dsc[@]}; i++)); do
    #Trim trailing whitespace and unnecessary slashes
    src[$i]="$( echo "${src[$i]}" | sed -e 's/[[:space:]]*$//')";
    dsc[$i]="$( echo "${dsc[$i]}" | sed -e 's/[[:space:]]*$//')";

    if [[ "${src[$i]: -1}" = *\* ]]; then
      for FILE in ${src[$i]}; do
        DEST="$( echo ${dsc[$i]} | envsubst )/$(basename "$FILE" )";
        SRC="$CONFIG/$FILE";
      done;
    else
      DEST="$( echo ${dsc[$i]} | envsubst )";
      SRC="$CONFIG/${src[$i]}";
    fi;

    #If this path is already taken by a directory - but not a linked directory
    if [[ -d "$DEST" && ! -L "$DEST" ]]; then      
      echo -e "Delete and replace? [y/n]\n$DEST\n\n> ";

      CONFIRM="";
      while [[ "$CONFIRM" != "y" && "$CONFIRM" != "n" ]]; do
        read -N 1 CONFIRM;
      done;

      if [ "$CONFIRM" == "y" ]; then
        CHANGE_LIST+="Replaced directory... ";
        rm -rf "$DEST";
      fi;

    #If this path=file & exists
    if [ "$( stat "$DEST" 2> /dev/null )" != "" ]; then
      CHANGE_LIST+="Replacing... ";
      rm -f "$DEST";
    fi;

    CHANGE_LIST+=">$(ln -vs "$SRC" "$DEST")\n";
  done;

  #Print created links
  echo -e "\n\n$( echo -e $CHANGE_LIST | column -s '>' -t -o '' )";

  #Pause so the user can read it
  echo -en "\nPress any key to continue...\n\n> ";
  read -N 1;
fi;



#INITIALIZE GIT SUBMODULES
GIT_INIT="";
while [[ "$GIT_INIT" != "y" && "$GIT_INIT" != "n" ]]; do
  clear;
  echo -e "User: $USER\nConfig dir: $CONFIG\nVariant: $VARIANT\n";
  
  echo -en "Initialize/update Git submodules? [y/n]\n\n> "

  read -N 1 GIT_INIT;
done;
echo -e "\n\n";

if [ "$GIT_INIT" == "y" ]; then
  git submodule update --init --recursive;
  git submodule update --recursive --remote
fi;
