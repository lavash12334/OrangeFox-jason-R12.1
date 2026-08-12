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
rm -f "$RAMDISK/system/lib64/libclang_rt.ubsan_standalone-aarch64-android.so"

# logd/logcat: the kernel has no UART console driver, logs are read from pstore
rm -f "$RAMDISK/system/bin/logd"
rm -f "$RAMDISK/system/bin/logcat"

# theme fonts: keep only Roboto and GoogleSans
for font in Chococooky EuclidFlex-Medium EuclidFlex-Regular Exo2-Medium \
            Exo2-Regular FiraCode-Medium FiraCode-Regular InterDisplay-Medium \
            InterDisplay-Regular RobotoSlab; do
    rm -f "$RAMDISK/twres/fonts/$font.ttf"
done

# translations: keep English and Russian
for lang in cs de el fr id it pl pt_PT ro tr ua; do
    rm -f "$RAMDISK/twres/languages/$lang.xml"
done

exit 0
