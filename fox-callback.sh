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
# (verified against the DT_NEEDED lists of every binary in the ramdisk)
rm -f "$RAMDISK/system/lib64/libncurses.so"
rm -f "$RAMDISK/system/lib64/libnl.so"
rm -f "$RAMDISK/system/lib64/libclang_rt.ubsan_standalone-aarch64-android.so"

# NOTE: libxml2.so must stay. It is not used by anything inside the ramdisk, but
# /vendor/lib64/libdrmfs.so needs it, and that library is loaded by the vendor
# qseecomd, which registers the QSEE listeners that keymaster (and therefore
# decryption) depends on.

# exFAT support (only used for OTG media)
rm -f "$RAMDISK/system/bin/exfat-fuse"
rm -f "$RAMDISK/system/bin/mkexfatfs"
rm -f "$RAMDISK/system/bin/fsck.exfat"
rm -f "$RAMDISK/system/lib64/libexfat_twrp.so"

# timezone database (only affects the displayed time zone)
rm -f "$RAMDISK/system/usr/share/zoneinfo/tzdata"

# command line keystore tool, not used by the recovery itself
rm -f "$RAMDISK/system/bin/keystore_cli_v2"

# translations: keep English and Russian
for lang in cs de el fr id it pl pt_PT ro tr ua; do
    rm -f "$RAMDISK/twres/languages/$lang.xml"
done

exit 0
