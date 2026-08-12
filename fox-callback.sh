#!/bin/sh
#
# OrangeFox local callback script for jason.
#
# The bootloader (ABL) copies the recovery ramdisk to 0x84280000, and the next
# reserved memory region in the device tree starts at 0x85600000
# (wlan_msa_guard, "removed-dma-pool" + no-map). That leaves 0x1380000 bytes
# (20447232, 19.5 MiB) for the compressed ramdisk:
#
#   ramdisk >  0x85800000 boundary -> ABL itself data-aborts while copying
#   ramdisk >  0x85600000 boundary -> ABL survives, the kernel dies instantly
#                                     because the ramdisk lands in no-map memory
#
# So the compressed ramdisk has to stay below ~20 MB. This script drops files
# that are not needed to boot or decrypt, and is called by the OrangeFox build
# system just before the recovery image is created.
#
RAMDISK="$1"
STAGE="$2"

[ "$STAGE" = "--first-call" ] || exit 0
[ -n "$RAMDISK" ] && [ -d "$RAMDISK" ] || exit 0

echo "-- jason callback: trimming the recovery ramdisk in $RAMDISK"

# libraries that nothing in the ramdisk links against
rm -f "$RAMDISK/system/lib64/libxml2.so"
rm -f "$RAMDISK/system/lib64/libncurses.so"
rm -f "$RAMDISK/system/lib64/libnl.so"
rm -f "$RAMDISK/system/lib64/libclang_rt.ubsan_standalone-aarch64-android.so"

# HAL interface libraries for hardware that recovery never talks to
# (vibrator, A/B boot control, oemlock, authsecret, weaver, confirmationui,
#  stats, storage health, suspend, wifi keystore, hidl token)
for lib in android.hardware.vibrator@1.0 android.hardware.vibrator@1.1 \
           android.hardware.vibrator@1.2 android.hardware.vibrator-V1-cpp \
           android.hardware.vibrator-V1-ndk_platform android.hardware.vibrator-V2-cpp \
           android.hardware.vibrator-V2-ndk_platform android.hardware.vibrator-V2-ndk \
           android.hardware.boot@1.0 android.hardware.boot@1.1 android.hardware.boot@1.2 \
           android.hardware.oemlock@1.0 android.hardware.authsecret@1.0 \
           android.hardware.weaver@1.0 android.hardware.confirmationui@1.0 \
           android.frameworks.stats@1.0 android.frameworks.stats-V1-ndk_platform \
           android.hardware.health.storage@1.0 android.hardware.health.storage-V1-ndk_platform \
           android.system.suspend@1.0 android.system.wifi.keystore@1.0 \
           android.hidl.token@1.0; do
    rm -f "$RAMDISK/system/lib64/$lib.so"
done

# logd/logcat: the kernel has no UART console driver, logs are read from pstore
rm -f "$RAMDISK/system/bin/logd"
rm -f "$RAMDISK/system/bin/logcat"

# translations: keep English and Russian
for lang in cs de el fr id it pl pt_PT ro tr ua; do
    rm -f "$RAMDISK/twres/languages/$lang.xml"
done

exit 0
