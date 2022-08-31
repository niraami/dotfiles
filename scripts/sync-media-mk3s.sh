#!/usr/bin/bash

CHANGE="$(rsync -rtn --itemize-changes --modify-window=1 --delete /home/niraami/Infotech/media/GCODE/MK3S/ /media/MK3S)"

if [[ ! -z "$CHANGE" ]]; then
  # Send notification
  notify-send -u normal -a systemd "sync-media-mk3s" "Started SD card sync for media/MK3S"

  # Sync files
  rsync -rt --modify-window=1 --delete /home/niraami/Infotech/media/GCODE/MK3S/ /media/MK3S
  # Finish transfers (flush cache)
  sync -f /media/MK3S

  # Send completion notification
  notify-send -u normal -a systemd "sync-media-mk3s" "SD card sync for media/MK3S finished"
else
  # Send skip notification
  notify-send -u normal -a systemd "sync-media-mk3s" "SD card is synchronized"
fi

# Sync to avoid race conditions
sync -f /media/MK3S
# Unmount
umount /media/MK3S
