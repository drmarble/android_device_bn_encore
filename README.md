This is an outline for building CM-12. for the Barnes&Noble Nook Color, a.k.a. Encore.
Currently storage and wifi are fixed. It runs but very slowly. Quadrant gives a score of 650 to 950. If you want a fast system run cm-7.2 (I like the Mirage version). This just proves that even an omap3 with 512m ram can still run current software. 
Sound is still broken. Chromium is broken in cm-12.1 so no browser. It works in cm-12.0.
Building userdebug instead of eng makes it much faster, Quadrant ~1300.

I am assuming you have experience in building custom roms. This isn't a set of cook book instructions. The exact branch names can and will change as progress is made so check before downloading. This is true for all the referenced repositories. This guide is probably full of errors so don't blame me if it locks up your encore (they are almost impossible to brick), trashes your linux build system, or kills your cat; YOU HAVE BEEN WARNED!

You will need the device tree. It is located at: 
https://github.com/drmarble/android_device_bn_encore/tree/cm-12.1-wip1. 

I use steven676's kernel which he has generously developed for this project. It can be found here: 
https://github.com/steven676/ti-omap-encore-kernel3/tree/encore-omap3-3.0.y-l-backports.

The kernel has to be built using gcc4.7. I don't know why so don't ask. You will need to add this to your local manifest or use other git methods to set it up. 
  <project name="platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" path="prebuilts/gcc/linux-x86/arm/arm-eabi-4.7" remote="aosp" revision="refs/tags/android-4.4.4_r2"/>
The commands to use this for kernel building are built into my BoardConfig.mk.

I modified vendor.bn because we now build prrsrvinit from source because our prebuilt one was not PIE (Position Independent Executable). The changes to bionic allow non-PIE to run but it is better (security) if we change this and don't allow PIE. That may happen in the future.
https://github.com/drmarble/proprietary_vendor_bn/tree/cm-12.1-wip

Bionic has been patched to allow non-PIE executables. This is a security risk which is why cm never merged this commit. If you want you can just apply this commit: git fetch http://review.cyanogenmod.org/CyanogenMod/android_bionic refs/changes/36/79136/3 && git cherry-pick FETCH_HEAD to the bionic tree. My repository has this commit merged.
https://github.com/drmarble/android_bionic/tree/non-PIE-12.1

The build system required several patches to build flashable zips. Fattire was very helpful in getting this part working. I had been taking the wrong approach in my earlier, non-booting efforts. 
https://github.com/drmarble/android_build/commits/encore-12.1

Note that I enlarged the size of /system in the encore device tree. Dexpreopting takes up more space but makes the first boot take less than an hour. I had already repartitioned my device to have a 1gb /system partition. If your system doesn't fit you could reduce the system size in BoardConfig.mk and get rid of more preinstalled apps in vendor/cm or get rid of WITH_DEXPREOPT in BoardConfig.mk. 

Currently it doesn't have bluetooth or and hwc. I have deleted the hardware/ti/omap3 directory. This isn't a part of cm anymore but you may still have this in your local manifest. I just made a blank branch in its directory: cd hardware/ti/omap3 ; rm -r * ; git checkout -b blank ; git commit -a ; ctrl-o, ctrl-x. Then I just checkout blank but can checkout other branches when I am trying to get this to compile. We really could use cexec.out. hwc would be nice too. 

I have fixed part of the problem with hardware/ti/omap3. The conficts were between omx and the ion implementation. I just removed the omx directory. Some additions from Rhyre on github are included. The tree is here:
https://github.com/drmarble/android_hardware_ti_omap3/tree/no-omx

Also note, I had repartitioned my emmc to use a data/media system. My data partition is large and media is gone. I also use an SD card though I do not install to it but rather do an emmc install. In theory, this should work with separate data and media partitions and no sd-card. I haven't tested it because I don't want to repartition again. 

To deal with data/media and sdcard installs a change to frameworks/base is required. It was written by steven676. I have incorporated it here:
https://github.com/drmarble/android_frameworks_base/tree/storage-config-12.1

Note, I will not upload a finished update.zip file because this is just far to experimental. I want to hear from other builders first. If you want to try out lollipop on your encore you are going to have to build it yourself.

Enjoy.


