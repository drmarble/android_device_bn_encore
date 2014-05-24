#!/system/bin/sh

PATH=/system/bin:/system/xbin:/sbin

BCB=/rom/BCB

[ -f "$BCB" ] || mount -t vfat -o sync,noatime,uid=1000,gid=1000,fmask=0117,dmask=0007 /dev/block/mmcblk0p2 /rom

case "$1" in
	recovery )
		# strlen("boot-recovery") = 13
		echo "boot-recovery" > "$BCB"
		# fill out the rest of the 32-byte command space and the 32-byte
		# status space ...
		dd if=/dev/zero of="$BCB" bs=1 count=51 seek=13

		# Add the arguments
		echo "recovery" >> "$BCB"
		# strlen("recovery\n") = 9
		cmdlen=9

		shift
		while [ $# -gt 0 ]; do
			echo "$1" >> "$BCB"
			cmdlen=$(($cmdlen + $(echo "$1" | wc -c)))
			shift
		done

		# Pad the argument space to 1024 bytes if necessary
		if [ "$cmdlen" -lt 1024 ]; then
			dd if=/dev/zero of="$BCB" bs=1 count=$((1024-$cmdlen)) seek=$(($cmdlen+64))
		fi
		;;
	* )
		# zero out the BCB
		dd if=/dev/zero of="$BCB" bs=1088 count=1
		;;
esac

sync

exit 0
