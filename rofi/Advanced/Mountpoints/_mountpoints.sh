#!/usr/bin/env bash
source ~/.config/env_config/.display;
THIS="$( cd "$(dirname "$0")"; pwd -P )";


Modi=();
Modi+=("Local:$THIS/modi_local.sh");
Modi+=("SSH:$THIS/modi_ssh.sh");
Modi+=("FTP:$THIS/modi_ftp.sh");
Modi+=("Samba:$THIS/modi_samba.sh");
_Modi=("Local");

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
