#!/usr/bin/env bash
cd "${0%/*}";

#original="/config/wallpaper/wallpaper.jpg";
#modified="./image.png";
#icon="./icon_dark.png";

#if [ "$1" == "--reset" ]; then rm $modified; exit; fi;

#if ! [ -a $modified ]; then 
#  convert $original -resize 1920x1080 $modified;
#fi;

i3lock \
  --textcolor=bbbbbbff\
  \
  --insidecolor=00000055\
  --insidevercolor=00000a80\
  --insidewrongcolor=bb000055\
  \
  --ringcolor=353535ff\
  --ringvercolor=353535ff\
  --ringwrongcolor=353535ff\
  \
  --linecolor=ff0000ff\
  --separatorcolor=ff0000ff\
  --keyhlcolor=ffffff22\
  --bshlcolor=bb000055\
  \
  --veriftext=""\
  --wrongtext="Access Denied"\
  --textsize=20\
  \
  --timestr="%H:%M:%S"\
  --timepos="ix-200:(h/6)"\
  --timecolor=ffffffff\
  --timefont="sans-serif"\
  --timesize=80\
  \
  --datepos="ix-200:(h/6)+50"\
  --datestr="%A %d.%m"\
  --datecolor=ffffffff\
  --datefont="sans-serif"\
  --datesize=26\
  \
  --modsize=12\
  --radius=100\
  \
  --blur=5\
  -S 0 -k -t;

#ICON       https://www.iconfinder.com/Ikonografia
