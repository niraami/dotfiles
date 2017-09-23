USER="areuz";
CONF="/.config";

function replace() {
  if [ -f "$1" ] || [ -d "$1" ]; then mv "$1" "$CONF/Backup"; rm -rf "$1";
  elif [ ! -d "$(dirname "$1")" ]; then mkdir "$(dirname "$1")";
  fi;

  ln -s "$2" "$1";
}

#Install dependencies
sudo -u "$USER" yaourt -S "$CONF/Setup/.dependencies" --noconfirm;

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
replace "/etc/vimrc" "$CONF/vim/vimrc";
replace "/home/$USER/.config/ranger" "$CONF/ranger/";
replace "/usr/bin/chromium" "$CONF/Apps/Chromium_Select/chromium_select.sh";
replace "/usr/bin/win_kvm" "$CONF/scripts/windows_kvm.sh";
replace "/usr/bin/pidlock" "$CONF/scripts/pidlock.sh";

#Other
replace "/home/$USER/.ncmpcpp" "$CONF/MPD/ncmpcpp/config";
