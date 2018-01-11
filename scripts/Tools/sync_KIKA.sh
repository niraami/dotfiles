#!/usr/bin/env bash

local_dir="/mnt/KIKA"

#Initialization
hostip=$(echo $(nmblookup "KIKA") | awk -F' ' '{ print $1 }');
if [ "$hostip" == "name_query" ]; then echo "KIKA is not available right now"; exit 1; fi;

#Code
if [ -d "/mnt/KIKA_share" ] && [ "$(mountpoint "/mnt/KIKA_share/" | awk -F ' ' '{ print $3 }')" != "not" ]; then
	echo "Unmounting old /mnt/KIKA_share/ ...";
       	sudo umount /mnt/KIKA_share/;
elif [ ! -d "/mnt/KIKA_share" ]; then sudo mkdir "/mnt/KIKA_share/";
fi;

if sudo mount -o user="70624" "//"$hostip"/70624/" "/mnt/KIKA_share/"; then
	echo -e "\nMount successful!\nTransfering data...";
	sudo rsync --verbose --recursive --checksum --chmod 777 --progress --ipv6 \
		"$local_dir" \
		"/mnt/KIKA_share/";
  sudo rsync --verbose --recursive --checksum --chmod 777 --progress --ipv6 \
    "/mnt/KIKA_share/" \
    "/media/falcon/Work/School/Adlerka_3B/";
	echo -e "Transfer successful!\n\nCleaning up...";
	sudo umount "/mnt/KIKA_share/";
	sudo rmdir "/mnt/KIKA_share/";
else
	echo "\nError mounting //"$hostip"/72624/!";
	echo "Cleaning up...";
	if [ -d "/mnt/KIKA_share/" ]; then sudo rmdir "/mnt/KIKA_share/"; fi;
	exit 2;
fi;

