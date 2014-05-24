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

# Run /boot/postrecoveryboot.sh if one was provided
mount -t vfat -o ro,umask=0022 /dev/block/by-name/boot /boot
[ -x /boot/postrecoveryboot.sh ] && /boot/postrecoveryboot.sh
umount /boot
