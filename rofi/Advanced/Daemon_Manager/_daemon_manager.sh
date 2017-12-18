#!/usr/bin/env bash

THIS="$( cd "$(dirname "$0")"; pwd -P )";


Modi=();
Modi+=("All:$THIS/modi_all.sh");
Modi+=("Enabled:$THIS/modi_enabled.sh");
Modi+=("Running:$THIS/modi_running.sh");
_Modi=("All");

#Rewrite modi as a comma delimited string
Modi="$(printf "%s," "${Modi[@]}")";
Modi="${Modi%?}";


Args=();
Args+=("-dpi" "$DPI"); 
Args+=("-theme" "default");
Args+=("-sidebar-mode");


if [ $# -eq 0 ]; then
  rofi -modi "$Modi" "${Args[@]}" -show "$_Modi";

fi;
