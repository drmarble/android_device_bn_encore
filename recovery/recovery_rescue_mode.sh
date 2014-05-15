#!/sbin/sh

# recovery_rescue_mode.sh -- detect a "rescue mode" recovery (recovery booted
# off SD card, but should manage eMMC) and set up the fsfinder symlinks
# accordingly
#
# Rescue mode operation is indicated by the presence of a file named
# recovery-rescue-mode under /boot; this allows use of an unmodified recovery
# initramfs in building rescue recovery images.

umask 022

mkdir -p /boot
mount -t vfat -o ro /dev/block/by-name/boot /boot

if [ -f /boot/recovery-rescue-mode ]; then
	# Redo the symlinks to point to eMMC
	ln -sf /dev/block/mmcblk0p1 /dev/block/by-name/boot
	ln -sf /dev/block/mmcblk0p6 /dev/block/by-name/userdata
	ln -sf /dev/block/mmcblk0p5 /dev/block/by-name/system
fi

umount /boot
: > /dev/.rescue_mode_configured

exit 0
