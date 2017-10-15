#!/usr/bin/env bash

DISPLAY=:0

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
  --textsize=30\
  \
  --timestr="%H:%M:%S"\
  --timepos="ix-200:(h/6)"\
  --timecolor=ffffffff\
  --timefont="sans-serif"\
  --timesize=90\
  \
  --datepos="ix-200:(h/6)+50"\
  --datestr="%A %d.%m"\
  --datecolor=ffffffff\
  --datefont="sans-serif"\
  --datesize=40\
  \
  --modsize=50\
  --radius=150\
  \
  --blur=6\
  -S 0 -k -t;
