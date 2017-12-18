#!/usr/bin/env bash
source ~/.config/env_config/.display;
THIS="$( cd "$(dirname "$0")"; pwd -P )";


Modi=();
Modi+=("All:$THIS/modi_all.sh");
Modi+=("Powered:$THIS/modi_powered.sh");
Modi+=("Connected:$THIS/modi_connected.sh");
_Modi=("All");

#Rewrite modi as a comma delimited string
printf -v Modi "%s," "${Modi[@]}";
Modi=${Modi%?};


Args=();
Args+=("-dpi" "$DPI"); 
Args+=("-theme" "default");
Args+=("-display-run" "Run");
Args+=("-sidebar-mode");


if [ $# -eq 0 ]; then
  rofi -modi "$Modi" "${Args[@]}" -show "$_Modi";

fi;
