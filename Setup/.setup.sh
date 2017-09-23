USER="areuz";
CONF="/.config";

OLDIFS="$IFS";
IFS=$(echo -en "\n\b");

function replace() {
  if [ -f "$1" ] || [ -d "$1" ]; then mv "$1" "$CONF/Backup"; rm -rf "$1";
  elif [ ! -d "$(dirname "$1")" ]; then mkdir "$(dirname "$1")";
  fi;

  ln -s "$2" "$1";
}

#Install dependencies
if [ "$1" == "deps" ]; then
  sudo -u "$USER" yaourt -S "$CONF/Setup/.dependencies.pac" --noconfirm;
fi;
if [ "$1" == "full" ]; then
  for PAC in $(find "$CONF" -name ".*.pac"); do
    sudo -u "$USER" yaourt -S "$PAC" ;#--noconfirm;
  done;
fi

#Everyday Essentials
replace "/home/$USER/.xinitrc" "$CONF/.xinitrc";
replace "/home/$USER/.config/i3/config" "$CONF/i3/config";
replace "/home/$USER/.Xdefaults" "$CONF/.Xdefaults";
replace "/home/$USER/.bash_profile" "$CONF/.bash_profile";
replace "/home/$USER/.bashrc" "$CONF/.bashrc";
replace "/home/$USER/.fonts" "$CONF/fonts/";
replace "/etc/environment" "$CONF/environment";

#Tor
replace "/etc/tor/torrc" "$CONF/tor/torrc";
replace "/etc/systemd/system/tor.service" "$CONF/tor/tor.service";
replace "/etc/systemd/system/multi-user.target.wants/tor.service" "$CONF/tor/tor.service";
replace "/usr/lib/systemd/system/tor.service" "$CONF/tor/tor.service";

#SSH


#Tools
replace "/usr/bin/chromium_" "$CONF/Apps/Chromium_Select/chromium_select.sh";
replace "/etc/vimrc" "$CONF/vim/vimrc";
replace "/home/$USER/.config/ranger" "$CONF/ranger/";
replace "/usr/bin/win_kvm" "$CONF/scripts/windows_kvm.sh";
replace "/usr/bin/pidlock" "$CONF/scripts/pidlock.sh";

#Other
replace "/home/$USER/.ncmpcpp" "$CONF/MPD/ncmpcpp/config";

IFS="$OLDIFS";
