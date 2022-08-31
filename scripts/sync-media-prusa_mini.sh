#!/usr/bin/bash

CHANGE="$(rsync -rtn --itemize-changes --modify-window=1 --delete /home/istokm/Infotech/media/GCODE/PRUSA_MINI/ /media/PRUSA_MINI)"

if [[ ! -z "$CHANGE" ]]; then
  # Send notification
  notify-send -u normal -a systemd "sync-media-prusa_mini" "Started SD card sync for media/PRUSA_MINI"

  # Sync files
  rsync -rt --modify-window=1 --delete /home/istokm/Infotech/media/GCODE/PRUSA_MINI/ /media/PRUSA_MINI
  # Finish transfers (flush cache)
  sync -f /media/PRUSA_MINI

  # Send completion notification
  notify-send -u normal -a systemd "sync-media-prusa_mini" "SD card sync for media/PRUSA_MINI finished"
else
  # Send skip notification
  notify-send -u normal -a systemd "sync-media-prusa_mini" "SD card is synchronized"
fi

# Sync to avoid race conditions
sync -f /media/PRUSA_MINI
# Unmount
umount /media/PRUSA_MINI
