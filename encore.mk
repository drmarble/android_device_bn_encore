#
# Copyright (C) 2009 The Android Open Source Project
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS += device/bn/encore/overlay

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
# Do we need/want a recovery-ramdisk.img?
#$(call build-recoveryimage-target, $@)

# make cm build happy
PRODUCT_COPY_FILES += \
    device/bn/encore/prebuilt/boot/dummy.img:boot.img

# Init files
PRODUCT_COPY_FILES += \
    device/bn/encore/init.encore.rc:root/init.encore.rc \
    device/bn/encore/init.encore.usb.rc:root/init.encore.usb.rc \
    device/bn/encore/ueventd.encore.rc:root/ueventd.encore.rc \
    device/bn/encore/fstab.encore:root/fstab.encore

#PRODUCT_PACKAGES += \
#    fsfinder \
#    configure_vold.sh \
#    configure_mountservice.sh \
#    mount_emmc_storage.sh

# CM Platform Library
PRODUCT_PACKAGES += \
     org.cyanogenmod.platform-res \
     org.cyanogenmod.platform \
     org.cyanogenmod.platform.xml

# key mapping and touchscreen files
PRODUCT_COPY_FILES += \
    device/bn/encore/prebuilt/usr/idc/cyttsp-i2c.idc:/system/usr/idc/cyttsp-i2c.idc \
    device/bn/encore/prebuilt/usr/idc/ft5x06-i2c.idc:/system/usr/idc/ft5x06-i2c.idc \
    device/bn/encore/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl

# PowerVR graphics driver configuration
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/etc/powervr.ini:system/etc/powervr.ini

# Wifi firmware (modules are built from source)
#PRODUCT_COPY_FILES += \
#    device/bn/encore/firmware/ti-connectivity/LICENSE:system/etc/firmware/ti-connectivity/LICENSE \
#    device/bn/encore/firmware/ti-connectivity/wl127x-fw-4-mr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-4-mr.bin \
#    device/bn/encore/firmware/ti-connectivity/wl127x-fw-4-plt.bin:system/etc/firmware/ti-connectivity/wl127x-fw-4-plt.bin \
#    device/bn/encore/firmware/ti-connectivity/wl127x-fw-4-sr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-4-sr.bin \
#    device/bn/encore/firmware/ti-connectivity/wl1271-nvs_127x.bin:system/etc/firmware/ti-connectivity/wl1271-nvs_127x.bin
PRODUCT_COPY_FILES += \
    hardware/ti/wlan/mac80211/firmware/127x/LICENCE:system/etc/firmware/ti-connectivity/LICENCE \
    device/bn/encore/prebuilt/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

PRODUCT_PACKAGES += \
    wpa_supplicant\
    wl127x-fw-4-sr.bin \
    wl127x-fw-4-mr.bin \
    wl127x-fw-4-plt.bin \
    wl1271-nvs_127x.bin

# Script to edit the shipped nvs file to insert the device's assigned MAC
# address
PRODUCT_PACKAGES += store-mac-addr.sh

# Bluetooth
PRODUCT_COPY_FILES += \
    device/bn/encore/firmware/TIInit_7.2.31.bts:/system/etc/firmware/TIInit_7.2.31.bts

# Hardware capabilities
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/permissions/core_hardware.xml:system/etc/permissions/core_hardware.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Media Profile
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/etc/media_profiles.xml:system/etc/media_profiles.xml \
   $(LOCAL_PATH)/etc/media_codecs.xml:system/etc/media_codecs.xml

#PRODUCT_COPY_FILES += \
#   frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
#   frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Clears the boot counter
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bin/clear_bootcnt.sh:/system/bin/clear_bootcnt.sh

# If you'd like to build the audio components from source instead of using
# the prebuilts, comment out the PRODUCT_COPY_FILES lines for audio above
# and uncomment the lines below, then see BoardConfig.mk for further
# instructions.
$(call inherit-product-if-exists, external/alsa-lib/alsa-lib-products.mk)
PRODUCT_PACKAGES += \
    libaudio \
    alsa.omap3

PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/prebuilt/alsa/libasound.so:obj/lib/libasound.so \
   $(LOCAL_PATH)/prebuilt/alsa/libasound.so:system/lib/libasound.so

PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/etc/audio_policy.conf:system/etc/audio_policy.conf \
   $(LOCAL_PATH)/etc/mixer_paths.xml:system/etc/mixer_paths.xml

# Art
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/poetry/poem.txt:root/sbin/poem.txt

# update the battery log info
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bin/log_battery_data.sh:/system/bin/log_battery_data.sh

ifeq ($(TARGET_PREBUILT_BOOTLOADER),)
    LOCAL_BOOTLOADER := device/bn/encore/prebuilt/boot/MLO
else
    LOCAL_BOOTLOADER := $(TARGET_PREBUILT_BOOTLOADER)
endif

ifeq ($(TARGET_PREBUILT_2NDBOOTLOADER),)
    LOCAL_2NDBOOTLOADER := device/bn/encore/prebuilt/boot/u-boot.bin
else
    LOCAL_2NDBOOTLOADER := $(TARGET_PREBUILT_2NDBOOTLOADER)
endif

# Boot files
PRODUCT_COPY_FILES += \
    $(LOCAL_BOOTLOADER):bootloader \
    $(LOCAL_2NDBOOTLOADER):2ndbootloader

# ramdisk_tools.sh -- use on-demand for various ramdisk operations, such as
# repacking the ramdisk for use on an SD card or alternate emmc partitions
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/ramdisk_tools.sh:ramdisk_tools.sh

# BCB updating (for reboot to recovery)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bin/update_bcb.sh:system/bin/update_bcb.sh \
    $(LOCAL_PATH)/prebuilt/bin/update_bcb.sh:recovery/root/sbin/update_bcb.sh

# additions to recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    $(LOCAL_PATH)/recovery/recovery_rescue_mode.sh:recovery/root/sbin/recovery_rescue_mode.sh \
    $(LOCAL_PATH)/recovery/recovery_emmc_protect.sh:recovery/root/sbin/recovery_emmc_protect.sh

PRODUCT_COPY_FILES += \
    device/bn/encore/releasetools/install-recovery.sh:$(PRODUCT_OUT)/ota_temp/SYSTEM/bin/install-recovery.sh \
    device/bn/encore/releasetools/recovery-from-boot.p:$(PRODUCT_OUT)/ota_temp/SYSTEM/recovery-from-boot.p

#TWRP
PRODUCT_COPY_FILES += device/bn/encore/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

# XXX MAGIC: build process will delete any existing init.*.rc files from the
# recovery image, then copy this file from the main initramfs to the recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/init.recovery.encore.rc:root/init.recovery.encore.rc

# Product specfic packages
PRODUCT_PACKAGES += \
    pvrsrvinit \
    libPVRScopeServices.so \
    hwcomposer.omap3 \
    lights.encore \
    sensors.encore \
    power.encore \
    uim-sysfs \
    libbt-vendor \
    libaudioutils \
    audio.a2dp.default \
    libaudiohw_legacy \
    audio.primary.encore \
    acoustics.default \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.default \
    tinycap \
    tinymix \
    tinyplay \
    com.android.future.usb.accessory \
    dhcpcd.conf \
    dspexec \
    libCustomWifi \
    libbridge \
    libomap_mm_library_jni \
    librs_jni \
    libtiOsLib \
    make_ext4fs

# OMX components
# Addition of LOCAL_MODULE_TAGS requires us to specify
# libraries needed for a particular device
PRODUCT_PACKAGES += \
    libI420colorconvert \
    libLCML \
    libOMX_Core \
    libOMX.TI.AAC.decode \
    libOMX.TI.AAC.encode \
    libOMX.TI.AMR.decode \
    libOMX.TI.AMR.encode \
    libOMX.TI.G711.decode \
    libOMX.TI.G711.encode \
    libOMX.TI.G722.decode \
    libOMX.TI.G722.encode \
    libOMX.TI.G726.decode \
    libOMX.TI.G726.encode \
    libOMX.TI.G729.decode \
    libOMX.TI.G729.encode \
    libOMX.TI.ILBC.decode \
    libOMX.TI.ILBC.encode \
    libOMX.TI.JPEG.decoder \
    libOMX.TI.JPEG.encoder \
    libOMX.TI.MP3.decode \
    libOMX.TI.Video.Decoder \
    libOMX.TI.Video.encoder \
    libOMX.TI.VPP \
    libOMX.TI.WBAMR.decode \
    libOMX.TI.WBAMR.encode \
    libOMX.TI.WMA.decode \
    libVendor_ti_omx

PRODUCT_PACKAGES += \
        libskiahw

# DRM
PRODUCT_PACKAGES += \
	libwvm

# from omap3.mk.

PRODUCT_PACKAGES += \
	libdomx \
	libstagefrighthw \
	libion_ti \
	smc_pa_ctrl \
	tf_daemon

PRODUCT_PACKAGES += \
	cexec.out

PRODUCT_CHARACTERISTICS := tablet

# Screen size is "large", density is "mdpi", need "hdpi" for extra drawables in 10.1
PRODUCT_AAPT_CONFIG := large mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set property overrides
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=128m \
    persist.sys.media.use-awesome=true \
    debug.sf.nobootanimation=1

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false \
    dalvik.vm.dex2oat-flags=--no-watch-dog \
    dalvik.vm.image-dex2oat-Xmx=256m \
    dalvik.vm.dex2oat-Xmx=256m

PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true \
	ro.mnt.sdcard0.emulated=true \
	ro.emulated_storage=true

#PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true \
#	ro.mnt.sdcard0.emulated=true \
#	ro.mnt.sdcard0.allowUMS=false \
#	ro.mnt.sdcard0.mtpReserve=256 \
#	ro.mnt.sdcard0.maxFileSize=0


PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/bn/encore/encore-vendor.mk)
$(call inherit-product, hardware/ti/wlan/mac80211/wl127x-wlan-products.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
#$(call inherit-product-if-exists, device/ti/proprietary-open/wl12xx/wlan/wl12xx-wlan-fw-products.mk)
