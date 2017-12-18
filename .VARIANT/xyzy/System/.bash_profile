#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
	#while [ 1 ]; do
		clear;
		#echo 'Start X Session?';
		#read -N 1 input;
		#input=$(echo "$input" | tr '[:upper:]' '[:lower:]');
		#if [ "$input" == "y" ] || [ "$input" == "yes" ]; then exec startx; break;
		#elif [ "$input" == "n" ] || [ "$input" == "no" ]; then clear; break;
		#fi;
	#done;
  exec startx;
fi;

