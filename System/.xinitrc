QT_QPA_PLATFORMTHEME=gtk2

xrdb -merge ~/.Xresources

xrandr --setprovideroutputsource modesetting NVIDIA-0;
xrandr --auto;

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec i3 &> /dev/null;
