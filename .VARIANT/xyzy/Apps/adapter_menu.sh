#!/usr/bin/env bash

data="$(connmanctl technologies)";

names=($(echo "$data" | grep "Name" | awk -F ' ' '{print $3}'));
types=($(echo "$data" | grep "Type" | awk -F ' ' '{print $3}'));
states=($(echo "$data" | grep "Power" | awk -F ' ' '{print $3}'));
count=$(echo ${#names[@]});

data="";

for ((i = 0 ; i < $count ; i++)); do
  if [ "${states[i]}" == "True" ]; then
    states[$i]="on";
  else
    states[$i]="off";
  fi;
  data+=$(echo "${types[i]} ${names[i]} ${states[i]} ");
done;

out="$(Xdialog --stdout --title "Comms Adapter Menu" --center --no-tags\
 --checklist "Adapters:" $(($count*3)) 40 $count $data)";

if [ $? == 1 ]; then exit; fi;

#echo "Xdialog --stdout --title "Comms Adapter Menu" --center --no-tags\
# --checklist "Adapters:" $((7 + $count*2)) 40 $count $data";

#echo -e "OUT: $out";

for ((i = 0 ; i < $count ; i++)); do
  #echo "DBG: ${types[i]} + ${states[i]}";

  if [[ ( -z "$out" || ! $out == *${types[i]}*) && ${states[i]} == "on" ]]; then
    connmanctl disable ${types[i]};
    #echo "Changing ${types[i]} to OFF";
  elif [[ $out == *${types[i]}* && ${states[i]} == "off" ]]; then
    connmanctl enable ${types[i]};
    #echo "Changing ${types[i]} to ON";
  fi;
done;
