#!/usr/bin/env bash

#Inicialization
if [ $# -lt 2 ] || [ "$(echo "$1" | awk -F'/' '{ print $4 }')" == "" ]; then echo -e "\nSyntax:" \
	"\nsamba_mount.sh //HOSTNAME/SHARE_NAME HOST_USERNAME;" \
	"\n\nHOSTNAME:   	the target computer Hostname - case sensitive." \
	"\nSHARE_NAME: 	can be a folder, file, service - all case sensitive." \
	"\nHOST_USERNAME:  the host's smbclient username (not neccesarily the computer user name in use.\n"; exit 0; fi;

hostname=$(echo "$1" | awk -F'/' '{ print $3 }');
hostip=$(echo $(nmblookup "$hostname") | awk -F' ' '{ print $1 }');

if [ "$hostip" == "name_query" ]; then echo "Hostname $hostname not found"; exit 0; fi;

#Functions
function change_path {
	while true; do
		echo "Enter a new folder name: /mnt/";
		read answer;
		if [ ! -z "${answer// }" ]; then local_path=/mnt/"$answer"/; break; fi;
	done;
}

#Code
remote_path=${1/"$hostname"/$hostip};
local_path=$(echo "$1" | awk -F'/' '{ print $NF }');
if [ "$local_path" == "" ]; then
	local_path=$(echo "$1" | awk -F'/' '{ print $(NF-1) }');
fi;
local_path=/mnt/"$local_path"/;


if [ -d "$local_path" ]; then
	if [ "$(mountpoint "$local_path" | awk -F ' ' '{ print $3 }')" == "not" ]; then
		echo "Directory $local_path already exists, do you want to remove it? [y/n]";
		read input;
		if [ "$input" == "y" ]; then
			sudo rmdir "$local_path";
		else
			change_path;
		fi;
	else
		echo "Directory $local_path is already in use as a mountpoint, do you want to unmount it? [y/n]";
		read input;
		if [ "$input" == "y" ]; then
			sudo umount "$local_path";
			sudo rmdir "$local_path";
		else
			change_path;
		fi;

	fi;
fi;

mkdir "$local_path";
if sudo mount -o user="$2" "$remote_path" "$local_path"; then
	sudo chmod 777 --recursive --silent "$local_path";
	cd "$local_path";
else
       	sudo rmdir "$local_path";
fi;

