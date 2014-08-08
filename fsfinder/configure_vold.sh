#!/system/bin/sh

# configure_vold.sh -- set up vold depending on boot location

FSTAB=/fstab.encore
FSTAB_NEW=/dev/fstab.encore

PATH=/sbin:/system/bin:/system/xbin
umask 0022

cp "$FSTAB" "$FSTAB_NEW"
fstab_modified=0

system_dev="`readlink /dev/block/by-name/system`"

# Configure vold to find /sdcard partition
case "$system_dev" in
	/dev/block/mmcblk1p* )
		# Get last partition on SD card
		partnum="`for i in /dev/block/mmcblk1p*; do echo ${i##/dev/block/mmcblk1p}; done | sort -rn | head -n 1`"

		# Update vold configuration for sdcard1
		sed -e "s/voldmanaged=sdcard1:auto/voldmanaged=sdcard1:$partnum,nonremovable/" "$FSTAB_NEW" > "$FSTAB_NEW".tmp
		mv "$FSTAB_NEW".tmp "$FSTAB_NEW"
		fstab_modified=1
		;;
	* )
		# No action required
		;;
esac

if [ ! -e /dev/block/mmcblk0p8 ]; then
	# Remove vold entry for sdcard0
	grep -v 'voldmanaged=sdcard0:' "$FSTAB_NEW" > "$FSTAB_NEW".tmp
	mv "$FSTAB_NEW".tmp "$FSTAB_NEW"
	fstab_modified=1
fi

# Mount modified fstab over the original so that vold will find it
if [ $fstab_modified -eq 1 ]; then
	mount -t bind -o bind "$FSTAB_NEW" "$FSTAB"

	# If in recovery, replace /etc/recovery.fstab too
	if [ -e /etc/recovery.fstab ]; then
		mount -t bind -o bind "$FSTAB_NEW" /etc/recovery.fstab
	fi
else
	rm -f "$FSTAB_NEW"
fi

: > /dev/.vold_configured

exit 0
