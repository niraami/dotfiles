#!/usr/bin/env bash

out=$(Xdialog --stdout --title "Power Menu" --screen-center --center --allow-close --no-tags \
	--menubox "Actions:" 28 80 8 \
	"1" "Shutdown [hard]" \
  "1" "Shutdown [soft]" \
	"2" "Shutdown [i3]" \
	"3" "Reboot [hard]" \
  "3" "Reboot [soft]" \
	"4" "Suspend";
);

case $out in
	1)
		systemctl poweroff;
		;;
	2)
		for proc in /tmp/pidlock/*; do
			kill "$(cat $proc)";
		done;
		i3-msg exit;
		;;
	3)
		systemctl reboot;
		;;
	4)
		systemctl suspend;
    ;;
esac;
