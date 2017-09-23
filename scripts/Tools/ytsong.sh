#!/usr/bin/env bash

#ADD CHECK FOR SUPPORTED FILE FORMATS!
#KILL TRAP ACTIVE EVEN ON SUCCESS
#ADD CHECK FOR DEPENDENCIES AND LOCK ARGUMENTS
#Dependencies:
# kid3/kid3-cli   - tag edit
# jq              - JSON parser
# ffmpeg          - song cutting

man="Usage: [command] [options] [URL]\n
Options:
  -h, --help                    display this message

  -f, --format                  output format
  -F, --file                    output file name

Embed options:
  -a. --art [file ...]          uses youtube thumbnail if file isn't specified  
  -A, --artist [string ...]     uses uploader username if string isn't specified
  -t, --title [string ...]      uses video title if string isn't specified

Post processing options:
  --cut [00:00:00] [00:00:00]   cut audio using start and end time

Advanced options:
  --dry
  --debug
  
  [URL]                         youtube link to song";

dbg="DEBUG:
format:     \$arg_format;
file:       \$arg_file;
art:        \$arg_art;
title:      \$arg_title;
artist:     \$arg_artist;
link:       \$arg_link;

cut:        \$arg_cut;
cut_start:  \$arg_cut_start;
cut_end:    \$arg_cut_end;

arg_dry:    \$arg_dry;
arg_debug:  \$arg_debug;

yt_arg:     \$yt_art;
kid3_arg:   \$kid3_arg;

formats:    \$formats;"
  
err1="process killed";
err2="missing arguments";

trap "echo Error 1: $err1;" EXIT;

#Function definitions:
function is_timecode() {
  if [[ "$1" == +([0-9][0-9]*(:[0-9][0-9]))?(.[0-9][0-9]) ]]; then
    echo 1;
  else
    echo 0;
  fi;
}

arg_format="flac";
arg_file="download";
arg_art="";
arg_title="";
arg_artist="";
arg_link="";

arg_cut=0;
arg_cut_start="00:00:00.00";
arg_cut_end="00:00:00.00";

arg_dry=0;
arg_debug=0;

yt_arg="";
kid3_arg="";

json="";
formats="$(youtube-dl --help | grep "audio-format" -A 3)";

for (( i = 1; i <= $#; i++)); do
  Arg="${!i}";
  if [ "$Arg" == "-h" ] || [ "$Arg" == "--help" ]; then
    echo -e "$man"; exit;
  elif [[ "$Arg" == -f* ]] || [[ "$Arg" == "--format*" ]]; then
    ((i++));
    arg_format="${!i}";
  elif [[ "$Arg" == -F* ]] || [[ "$Arg" == "--file*" ]]; then 
    ((i++));
    arg_file="${!i}";
  elif [[ "$Arg" == -a* ]] || [[ "$Arg" == "--art*" ]]; then
    ((i++));
    if [[ "${!i}" == -* ]] || [ $i -eq $# ]; then
      arg_art="1";
      ((i--));
    else
      arg_art="${!i}";
    fi;
  elif [[ "$Arg" == -A* ]] || [[ "$Arg" == "--artist*" ]]; then
    ((i++));
    if [[ "${!i}" == -* ]] || [ $i -eq $# ]; then
      arg_artist="1";
      ((i--));
    else
      arg_artist="${!i}";
    fi;
  elif [[ "$Arg" == -t* ]] || [[ "$Arg" == "--title*" ]]; then 
    ((i++));
    if [[ "${!i}" == -* ]] || [ $i -eq $# ]; then
      arg_title="1";
      ((i--));
    else
      arg_title="${!i}";
    fi;
  elif [[ "$Arg" == "--cut" ]]; then
    arg_cut=1;
    ((i=i+2));
    if [[ "$(is_timecode "${!i}")" == "1" ]]; then
      ((i--));
      arg_cut_start="${!i}";
      ((i++));
      arg_cut_end="${!i}";
    else
      ((i--));
      if [[ "$(is_timecode "${!i}")" == "1" ]]; then
        arg_cut_end="${!i}";
      else
        echo "Error 2: $err2";
        exit 2;
      fi;
    fi;
  elif [[ "$Arg" == "--dry" ]]; then
    arg_dry=1;
  elif [[ "$Arg" == "--debug" ]]; then
    arg_debug=1;
  else
    arg_link="${!i}";
  fi;
done;

##Check if all required variables are assigned
if [ $# -eq 0 ]; then echo -e "$man"; exit;
elif [ -z "$arg_format" ] || [ -z "$arg_file" ] || [ -z "$arg_link" ]; then
  echo "Error 2: $err2";
  #echo -e "arg_format: "$arg_format"\narg_file: "$arg_file"\narg_link: "$arg_link"";
  #echo -e "arg_art: "$arg_art"\narg_artist: "$arg_artist"\narg_title: "$arg_title"";
  exit 2;
fi;

##Concatenate youtube-dl arguments
yt_arg+=" -o \"$arg_file.%(ext)s\"";
yt_arg+=" --audio-format \"$arg_format\"";
yt_arg+=" --no-playlist";

if [ "$arg_art" == "1" ]; then
  yt_arg+=" --write-thumbnail";
fi;

##END OF INITIALIZATION##
if [ $arg_debug == 1 ]; then
  echo "$dbg";
fi;
if [ $arg_dry == 1 ]; then exit 0; fi;

##Run youtube-dl with preassigned arguments
eval "youtube-dl -x --write-info-json$yt_arg $arg_link";

json="$(cat "$(find ./ -cmin -1 -name "*.json")")";
rm "$(find ./ -cmin -1 -name "*.json")";

##Art check
if [ "$arg_art" == "1" ]; then
  arg_run+=" -c 'set picture:\"./"$arg_file".jpg\" \"\"'";
elif [ ! -z "$arg_art" ]; then
  arg_run+=" -c 'set picture:\""$arg_art"\" \"\"'";
fi;

##Title check
if [ "$arg_title" == "1" ]; then
  arg_run+=" -c 'set title \""$(echo "$json" | jq -r ".title")"\"'";
elif [ ! -z "$arg_title" ]; then
  arg_run+=" -c 'set title \""$arg_title"\"'";
fi;

##Artist check
if [ "$arg_artist" == "1" ]; then
  arg_run+=" -c 'set artist \""$(echo "$json" | jq -r ".uploader")"\"'";
elif [ ! -z "$arg_artist" ]; then
  arg_run+=" -c 'set artist \""$arg_artist"\"'";
fi;

##Cut
if [ $arg_cut == 1 ]; then
  ffmpeg -i "$arg_file.$arg_format" -ss "$arg_cut_start" -to "$arg_cut_end" "$arg_file_.$arg_format";
  mv "$arg_file_.$arg_format" "$arg_file.$arg_format";
fi;

##Write metadata
if [ ! -z "$arg_run" ]; then eval "kid3-cli $arg_run ./'"$arg_file"'.$arg_format"; fi;

##Cleanup
if [ -f "$arg_file.jpg" ]; then rm "$arg_file.jpg"; fi;

trap - EXIT;
