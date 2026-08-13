#
# Copyright (C) 2026 The OrangeFox Recovery Project
#

export FOX_BUILD_TYPE="Unofficial"
export FOX_MAINTAINER_PATCH_VERSION="1"
export OF_MAINTAINER="lavash12334"
export FOX_MAINTAINER="lavash12334"
export FOX_BUILD_DEVICE="jason"
export FOX_TARGET_DEVICES="jason"

# OrangeFox Options & Features
# Ramdisk compression: the 4.19 kernel config (extracted via CONFIG_IKCONFIG from
# Image.gz-dtb) only has CONFIG_RD_GZIP=y and CONFIG_RD_LZ4=y, so LZMA/XZ ramdisks
# cannot be decompressed by this kernel. Keep the default gzip compression.
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_REPLACE_BUSYBOX_PS=0
export TW_EXCLUDE_NANO=true
export TW_EXCLUDE_PYTHON=true

# Size limits: the ramdisk is copied to 0x84280000 and the first no-map reserved
# region starts at 0x85600000, so the compressed ramdisk must stay under 20 MB.
export FOX_REMOVE_BASH=1
export FOX_EXCLUDE_NANO_EDITOR=1
export FOX_REMOVE_AAPT=1
# This device calls its vendor partition "cust".
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/bootdevice/by-name/cust"
export FOX_LOCAL_CALLBACK_SCRIPT="${ANDROID_BUILD_TOP:-$(pwd)}/device/xiaomi/jason/fox-callback.sh"

export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_DONT_PATCH_ENCRYPTION=1
export OF_SKIP_MULTIUSER=1
export OF_USE_HEX_OPTIMLIBS=1
export OF_VANILLA_BUILD=0
export OF_MANUAL_ROOT_VENDOR_ERROR_FIX=1

# Display & UI Geometry (Mi Note 3: 1080x1920, HDPI)
export TARGET_SCREEN_WIDTH=1080
export TARGET_SCREEN_HEIGHT=1920
export OF_SCREEN_H=1920
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_ALLOW_DISABLE_NAVBAR=0
export OF_CLOCK_POS=1

# NOTE: Crypto/FBE/Keymaster flags are set in BoardConfig.mk and fox_jason.mk.
# Do NOT duplicate or override them here to avoid conflicts.

# Add lunch combos
add_lunch_combo fox_jason-eng
add_lunch_combo fox_jason-userdebug
add_lunch_combo twrp_jason-eng
add_lunch_combo twrp_jason-userdebug
