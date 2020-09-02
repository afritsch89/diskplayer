#!/usr/bin/env bash
exec >> /home/pi/mount.log 2>&1
export LC_ALL=en_GB.utf-8
export LANG=en_GB.utf-8

echo "$(date) Start."
echo "$(date) Media change detected on device $1"

device=${1##*/}

lsblk | grep $device

if [ $? -eq 0 ]; then
    echo "$(date) Device exists on machine."
    echo "$(date) Mounting device $1 to /media/floppy."
    /usr/bin/systemd-mount  $1 /media/floppy
    #runuser -l pi -c 'systemctl --user start spotifyd.service'
    #cd /opt
    #/opt/player --path /media/floppy/diskplayer.contents
    runuser -l pi -c 'player --path /media/floppy/diskplayer.contents'
    /usr/bin/systemd-mount --umount /media/floppy
else
    echo "$(date) Device does not exist on machine."
    #cd /opt
    #/opt/player --pause
    runuser -l pi -c '/home/pi/player --pause'
    #systemctl stop spotifyd.service
fi
echo "$(date) End."
