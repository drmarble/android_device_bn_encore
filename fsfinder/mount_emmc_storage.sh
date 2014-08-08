#!/system/bin/sh

# mount_emmc_storage.sh -- mount eMMC storage based on install location and
# partition layout

PATH=/sbin:/system/bin:/system/xbin
umask 0022

# Traditional eMMC layouts (separate FAT32 /emmc partition) are handled
# automatically by vold
if [ -e /dev/block/mmcblk0p8 ]; then
	exit 0
fi

system_dev="`readlink /dev/block/by-name/system`"
case "$system_dev" in
	/dev/block/mmcblk1p* )
		# SD card install
		# Mount eMMC's /data partition first
		mount -t ext4 -o noatime,nosuid,nodev,barrier=1,noauto_da_alloc /dev/block/mmcblk0p6 /mnt/media_rw/emmcdata || exit 1

		# Now start the FUSE sdcard service
		setprop ctl.start fuse_emmcmedia
		;;
	* )
		# eMMC install
		# Use /data/media for /emmc
		setprop ctl.start fuse_datamedia
		;;
esac

exit 0
