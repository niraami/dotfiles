#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
	while [ 1 ]; do
		clear;
		echo 'Start X Session?';
		read -N 1 input;
		input=$(echo "$input" | tr '[:upper:]' '[:lower:]');
		if [ "$input" == "y" ] || [ "$input" == "yes" ]; then 
      sudo mv /etc/X11/xorg.conf.d/20-nvidia.* "/etc/X11/xorg.conf.d/20-nvidia.blocked";
      sudo mv /etc/X11/xorg.conf.d/20-intel.* "/etc/X11/xorg.conf.d/20-intel.conf";
      exec startx;
      break;
    elif [ "$input" == "g" ] || [ "$input" == "gpu" ]; then
      sudo mv /etc/X11/xorg.conf.d/20-nvidia.* "/etc/X11/xorg.conf.d/20-nvidia.conf";
      sudo mv /etc/X11/xorg.conf.d/20-intel.* "/etc/X11/xorg.conf.d/20-intel.blocked";
      exec startx;
      break;
		elif [ "$input" == "n" ] || [ "$input" == "no" ]; then clear; break;
		fi;
	done;
fi;

