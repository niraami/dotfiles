USER="areuz";
CONF="/.config";

OLDIFS="$IFS";
IFS=$(echo -en "\n\b");

function ln_replace() {
  if [ -a "$1" ] || [ -d "$1" ] || [ -h "$1" ]; then 
    mkdir -p "$BAK";
    mv "$1" "$BAK/"; rm -f "$1";
  elif [ ! -d "$(dirname "$1")" ]; then mkdir "$(dirname "$1")";
  fi;

  ln -s "$2" "$1";
}

#Choose VARIANT
SEL="NULL";
while [ ! -d "$CONF/.VARIANT/$SEL" ]; do
  tput reset;

  echo -e "Choose environment variant:";
  for V in $CONF/.VARIANT/*; do
    echo -e "  $(basename $V)";
  done;
  echo -en "\n>";

  read SEL;
done;

for File in $(find "$CONF/.VARIANT/$SEL" -type f -o -type l); do
  rm "$CONF/$(echo "$File" | cut -d '/' -f 5-)";
done;

IFS="$OLDIFS";
