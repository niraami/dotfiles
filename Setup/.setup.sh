USER="areuz";
CONF="/.config";

OLDIFS="$IFS";
IFS=$(echo -en "\n\b");

function replace() {
  if [ -f "$1" ] || [ -d "$1" ]; then mv "$1" "$CONF/Backup"; rm -f "$1";
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

#System Essentials
replace "/home/$USER/.xinitrc" "$CONF/System/.xinitrc";
replace "/home/$USER/.config/i3/config" "$CONF/System/i3/config";
replace "/home/$USER/.bash_profile" "$CONF/System/.bash_profile";
replace "/home/$USER/.bashrc" "$CONF/System/.bashrc";
replace "/home/$USER/.fonts" "$CONF/System/fonts/";
replace "/etc/environment" "$CONF/System/environment";
replace "/etc/systemd/logind.conf" "$CONF/System/logind.conf";
replace "/etc/modprobe.d/alsa-base.conf" "$CONF/System/alsa-base.conf";
replace "/etc/vconsole.conf" "/$CONF/System/vconsole.conf";

#Xorg
replace "/home/$USER/.Xdefaults" "$CONF/System/.Xdefaults";
replace "/home/$USER/.Xresources" "$CONF/System/.Xresources";
replace "/etc/X11/xorg.conf.d/30-touchpad.conf" "$CONF/System/Xorg/30-touchpad.conf";
replace "/etc/X11/xorg.conf.d/90-monitor.conf" "$CONF/System/Xorg/90-monitor.conf";

#Themes
replace "/home/$USER/.config/Trolltech.conf" "$CONF/Trolltech.conf";
replace "/usr/share/themes/Iris_Night" "$CONF/Themes/Iris Night";
replace "/usr/share/icons/Flat_Remix" "$CONF/Themes/Flat-Remix/Flat Remix";

#Tor
replace "/etc/tor/torrc" "$CONF/System/tor/torrc";
#replace "/etc/systemd/system/tor.service" "$CONF/System/tor/tor.service";
#replace "/etc/systemd/system/multi-user.target.wants/tor.service" "$CONF/System/tor/tor.service";
replace "/usr/lib/systemd/system/tor.service" "$CONF/System/tor/tor.service";

#SSH
replace "/etc/ssh" "$CONF/System/ssh";
replace "/etc/systemd/system/sockets.target.wants/sshd.socket" "$CONF/System/ssh/sshd.socket";
replace "/usr/lib/systemd/system/sshd.socket" "$CONF/System/ssh/sshd.socket";
replace "/home/$USER/.ssh/known_hosts" "$CONF/System/ssh/known_hosts";

#LAMP
replace "/etc/httpd" "$CONF/LAMP/httpd";
replace "/srv/http" "$CONF/LAMP/http";
replace "/etc/php" "$CONF/LAMP/php";

#Tools
replace "/usr/bin/chromium_" "$CONF/Apps/Chromium_Select/chromium_select.sh";
replace "/etc/vimrc" "$CONF/vim/vimrc";
replace "/home/$USER/.config/ranger" "$CONF/ranger/";
replace "/usr/bin/win_kvm" "$CONF/scripts/windows_kvm.sh";
replace "/usr/bin/pidlock" "$CONF/scripts/pidlock.sh";

#Other
replace "/home/$USER/.ncmpcpp" "$CONF/MPD/ncmpcpp/config";

chmod 777 -R "$CONF/";
chown areuz:areuz -R "$CONF/";

IFS="$OLDIFS";
