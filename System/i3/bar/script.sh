#!/usr/bin/env bash
cd "${0%/*}";

BOOT=true;

ICLOCK=10; 	#Cycle (I)nterval
NCLOCK=0; 	#(N)umber of cycles since last update
OCLOCK=""; 	#Last saved (O)utput

IDATE=100;
NDATE=0;
ODATE="";

IKEY=5;
NKEY=0;
OKEY="";

IBAT=50;
NBAT=0;
OBAT="";

INETWORK=20;
NNETWORK=0;
ONETWORK="";

echo -e '{ "version": 1 }\n[';

while [ 1 ]; do
	((NCLOCK++));
	((NDATE++));
	((NKEY++));
	((NBAT++));
	((NNETWORK++));

	if [ $NCLOCK == $ICLOCK ] || [ "$BOOT" = true ]; then OCLOCK="$(./scripts/clock.sh)"; NCLOCK=0; fi;
	if [ $NDATE == $IDATE ] || [ "$BOOT" = true ]; then ODATE="$(./scripts/date.sh)"; NDATE=0; fi;
	if [ $NKEY == $IKEY ] || [ "$BOOT" = true ]; then OKEY="$(./scripts/key_layout.sh)"; NKEY=0; fi;
	if [ $NBAT == $IBAT ] || [ "$BOOT" = true ]; then OBAT="$(./scripts/battery.sh)"; NBAT=0; fi;
	
	if [ "$OBAT" != "" ]; then output+="$OBAT,"; fi;
	if [ "$OKEY" != "" ]; then output+="$OKEY,"; fi;
	if [ "$ODATE" != "" ]; then output+="$ODATE,"; fi;
	if [ "$OCLOCK" != "" ]; then output+="$OCLOCK,"; fi;

	if [ "$output" != "" ]; then
		echo -e "[${output%,}],\n";
		output="";
	else
		echo -e "[{\"full_text\":\"ERR: No output received\",\"color\":\"#ff0000\"}],\n";
	fi;
	
	if [ "$BOOT" = true ]; then BOOT=false; fi;
	sleep 0.1s;
done;
