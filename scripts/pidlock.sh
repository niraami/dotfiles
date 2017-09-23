#!/usr/bin/env bash
cd "${0%/*}";

man="Usage: pidlock -[hclu] [NAME] optional [PID]\n
	-h, --help	Display this message		Output: [man]
	-c, --check	Check for lock 			Output: [0|127]
	-l, --lock	Create lock			Output: [0|127]
	-u, --unlock	Free lock			Output: [0|127]
	-k, --kill 	Free lock + Kill process	Output: [0|127]";

option="$1";
name=${2//[[:blank:]]/};
if [ "$3" == "" ]; then
	PID=$PPID;
else
	PID=${3//[[:blank:]]/};
fi;

if [[ "$option" == "-h" || "$option" == "--help" ]]; then echo -e "$man"; exit 1; fi;
if [ ! -d /tmp/pidlock/ ]; then mkdir /tmp/pidlock/; fi;

pidfile="/tmp/pidlock/$name.lock";

function check_pid() {
	if [ -a "$pidfile" ]; then
		local __PID=$(cat $pidfile);
		if ps -p $__PID > /dev/null; then
			echo 127;
		else
			rm $pidfile;
			echo 0;
		fi;
	else
		echo 0;
	fi;
}

function lock_pid() {
	if [ $(check_pid) == 0 ]; then
		echo $PID > $pidfile;
		echo 0;
	else
		echo 127;
	fi;
}

function unlock_pid() {
	if [ $(check_pid) == 0 ]; then
		echo 127;
	else
		rm $pidfile;
		echo 0;
	fi;
}

function kill_pid() {
	if [ $(check_pid) == 0 ]; then
		echo 127;
	else
		kill $(cat $pidfile);
		echo 0;
	fi;
}

if [[ $option == "-c" || $option == "--check" ]]; then
	exit $(check_pid);
elif [[ $option == "-l" || $option == "--lock" ]]; then
	exit $(lock_pid);
elif [[ $option == "-u" || $option == "--unlock" ]]; then
	exit $(unlock_pid);
elif [[ $option == "-k" || $option == "--kill" ]]; then
	exit $(kill_pid);
else
	echo "Err";
	exit 1;
fi;


