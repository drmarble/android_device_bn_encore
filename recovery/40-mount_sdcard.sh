#!/sbin/sh
#
# mount_sdcard.sh
# mount /dev/block/mmcblk1p1 on /sdcard 
# gapps addon script needs /sdcard to hold files
# since we don't have enough space on the ram disk /tmp

rm /sdcard
mkdir /sdcard
mount -t vfat  /dev/block/mmcblk1p1 /sdcard/

exit 0
