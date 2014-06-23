#!/sbin/sh

# Ensure /rom is mounted sync (init may not support the mount flag)
mount -o remount,sync /rom
sync

if [ -f /dev/.recovery_rescue_mode ]; then
	# /boot points to eMMC, but our instructions are on SD card
	mount -t vfat -o ro,umask=0022 /dev/block/mmcblk1p1 /boot
else
	mount -t vfat -o ro,umask=0022 /dev/block/by-name/boot /boot
fi
# If a command file for the recovery was provided in /boot, write the arguments
# to the BCB so that the recovery will find them
if [ -f /boot/recovery-commands ]; then
	recovery_args=""
	while read arg; do
		[ -z "$arg" ] && continue
		recovery_args="$recovery_args $arg"
	done < /boot/recovery-commands
	if [ "$recovery_args" ]; then
		/sbin/update_bcb.sh recovery $recovery_args
	fi
fi
# Run /boot/postrecoveryboot.sh if one was provided
[ -x /boot/postrecoveryboot.sh ] && /boot/postrecoveryboot.sh
umount /boot
