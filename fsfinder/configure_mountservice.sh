#!/system/bin/sh

# configure_mountservice.sh -- configure mount service based on boot location
# and partition layout

PATH=/sbin:/system/bin:/system/xbin
umask 0022

system_dev="`readlink /dev/block/by-name/system`"
case "$system_dev" in
	/dev/block/mmcblk1p* )
		# Mark SD card nonremovable for framework
		setprop ro.mnt.sdcard1.removable false
		;;
	* )
		# No action required
		;;
esac

if [ ! -e /dev/block/mmcblk0p8 ]; then
	# Tell the framework that eMMC storage is emulated
	setprop ro.mnt.sdcard0.emulated true
	setprop ro.mnt.sdcard0.allowUMS false
	setprop ro.mnt.sdcard0.mtpReserve 256
	setprop ro.mnt.sdcard0.maxFileSize 0
fi

: > /dev/.mountservice_configured

exit 0
