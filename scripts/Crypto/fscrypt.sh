#!/usr/bin/env bash

man="Usage:  namecrypt [ -h ] [ -e || -d ] [ -F ] [ -D ] [ -r ] [DIRECTORY] [PASSPHRASE]\n
	-h, --help		display this message

	-e, --encrypt 		encrypt the specified directory
	-d, --decrypt 		decrypt the specified directory
	
	-r, --recursive		use recursive search
	-F, --files		include files
	-D, --dir		include directories

	[DIRECTORY]		relative or absolute path to a directory/symbolic link
	[PASSPHRASE]		optional - specify the user passphrase on command line";

options=();
for Arg in "$@"; do
	if [ "$Arg" == "-h" ] || [ "$Arg" == "--help" ]; then
		echo -e "$man"; exit; 
	elif [ "$Arg" == "-e" ] || [ "$Arg" == "--encrypt" ]; then
		options[0]="E";
	elif [ "$Arg" == "-d" ] || [ "$Arg" == "--decrypt" ]; then
		options[0]="D";
	elif [ "$Arg" == "-F" ] || [ "$Arg" == "--files" ]; then
		options[1]="${options[1]}F";
	elif [ "$Arg" == "-D" ] || [ "$Arg" == "--dir" ]; then
		options[1]="${options[1]}D";
	elif [ "$Arg" == "-r" ] || [ "$Arg" == "--recursive" ]; then
		options[2]="R";
	elif [ -d "$Arg" ]; then
		options[3]="$(realpath "$Arg")";
	else	
		options[4]="$Arg";		
	fi;
done;

if [ "${options[3]}" == "" ]; then echo "No such directory!"; exit 2; fi;
if [ "${options[4]}" == "" ]; then echo "Enter a passphrase: "; read options[4]; fi;

shopt -s nullglob dotglob;

function hashTarget
{
	path="$1";
	[ -f "$path" ] && ccencrypt -s -K "${options[4]}" "$path" && path="$path.cpt";
	
	BASE="$(basename "$path")";
	DIR="$(dirname "$path")/";

	if [ -a "$path" ]; then
		newName=$(echo "$BASE" | md5sum | awk -F ' ' '{print $1}');
		echo "$BASE||$newName" >> "$DIR.names";
		mv "$path" "$DIR$newName";
	else 
		echo "Skipping '$path' - No such file or directory!";
	fi;
}

function dehashTarget
{
	BASE="$(basename "$1")";
	DIR="$(dirname "$1")/";

	[ -f "$DIR.names.cpt" ] && ccdecrypt -K "${options[4]}" "$DIR.names.cpt";
	
	if [ -f "$DIR.names" ]; then
		newName=$(grep "$BASE" "$DIR.names" | awk -F '|' '{print $1}');
		[[ ! -z "${newName// }" ]] && mv "$1" "$DIR$newName";

		[ -f "$DIR$newName" ] && ccdecrypt -K "${options[4]}" "$DIR$newName";
	else 
		echo "Skipping '$1' - Hash table not found!";
	fi;
}

function mapTarget
{	
	DIR="$(dirname "$1")/";
	
	if [ "${options[2]}" == "R" ]; then 
		for Dir in "$1"/*/; do mapTarget "$Dir"; done;
	fi;

	for Item in "$1"/*; do
		if ([ -f "$Item" ] && [[ "${options[1]}" == *"F"* ]]) || 
		   ([ -d "$Item" ] && [[ "${options[1]}" == *"D"* ]]); then

			if [ "${options[0]}" == "E" ]; then
				hashTarget "$Item";
			elif [ "${options[0]}" == "D" ]; then
				dehashTarget "$Item";
			fi;
		fi;
	done;

	[ "${options[0]}" == "D" ] && [ -f "$DIR.names" ] && rm "$DIR.names";
	[ "${options[0]}" == "E" ] && [ -f "$DIR.names" ] && ccencrypt -K "${options[4]}" "$DIR.names";
}

mapTarget "${options[3]}";

echo "Everything completed successfully!";
exit 0;
