if [ -d /etc/X11/xinit/xinitrc.d ] ; then
        for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

# Start gnome-keyring daemon with extra components
eval $(/usr/bin/gnome-keyring-daemon --start -dl -c pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Disable screen blanking & DPMS
xset dpms 0 0 0

exec i3
