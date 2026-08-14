#!/bin/sh
#
# OrangeFox local callback script for jason.
#
# It no longer deletes anything: since the recovery switched to the ROM's 4.4
# kernel the ramdisk is compressed with LZMA (OF_USE_LZMA_COMPRESSION=1), which
# brought it from 20 390 676 bytes down to 13 236 246 - about 7 MB below the
# limit, so the files that used to be stripped here (tzdata, the exFAT tools,
# most translations, keystore_cli_v2, a few libraries) all fit again.
#
# Keep the script: it documents the limit, and it is the place to trim the
# ramdisk again if it ever grows past it.
#
# THE LIMIT: the bootloader (ABL) copies the recovery ramdisk to 0x84280000 and
# the first no-map reserved region (wlan_msa_guard) starts at 0x85600000, so the
# compressed ramdisk must stay below 0x1380000 = 20 447 232 bytes:
#
#   ramdisk > 20 447 232 -> ABL survives, the kernel dies instantly because the
#                           ramdisk lands in no-map memory (nothing in pstore)
#   ramdisk > 22 544 384 -> ABL itself data-aborts while copying
#
# Check every build with: node F:\minote3\tools\inspect.js <recovery.img>
#
RAMDISK="$1"
STAGE="$2"

[ "$STAGE" = "--first-call" ] || exit 0
[ -n "$RAMDISK" ] && [ -d "$RAMDISK" ] || exit 0

echo "-- jason callback: nothing to trim (LZMA ramdisk, ~7 MB of headroom)"

# NOTE: libxml2.so must stay in the ramdisk. Nothing inside it links against
# libxml2, but /vendor/lib64/libdrmfs.so needs it, and that library is loaded by
# the vendor qseecomd, which registers the QSEE listeners that keymaster - and
# therefore decryption - depends on.

exit 0
