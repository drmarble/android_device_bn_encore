#!/sbin/sh

# Resets the boot counter and the bcb instructions
mkdir /rom
mount /dev/block/mmcblk0p2 /rom
mount -o rw,remount /rom

# Zero out the boot counter
dd if=/dev/zero of=/rom/devconf/BootCnt bs=1 count=4

# Set up a "device" for the BCB
ln -s /rom/BCB /dev/block/by-name/bcb

# Symlink /system/bin to /sbin for compatibility with the reboot-recovery
# script and other shell scripts for the regular, non-recovery environment
rmdir /system/bin
ln -s /sbin /system/bin

# Align /sdcard and /emmc with their usage in the non-recovery environment
rmdir /emmc
ln -s /storage/sdcard0 /emmc
rmdir /sdcard
ln -s /storage/sdcard1 /sdcard

mount -t vfat -o ro,umask=0022 /dev/block/by-name/boot /boot
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
