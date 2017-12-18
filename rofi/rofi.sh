#!/usr/bin/env bash
THIS="$( cd "$(dirname "$0")"; pwd -P )";

Modi=();
Modi+=("run");
Modi+=("Advanced:$THIS/advanced.sh");
_Modi=("run");

#Rewrite modi as a comma delimited string
printf -v Modi "%s," "${Modi[@]}";
Modi=${Modi%?};


Args=();
Args+=("-theme" "default");
Args+=("-display-run" "Run");
Args+=("-sidebar-mode");


rofi -modi "$Modi" "${Args[@]}" -show "$_Modi"
