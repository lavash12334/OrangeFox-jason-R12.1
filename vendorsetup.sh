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

# OS version and security patch level reported by the recovery.
#
# The vendor keymaster 3.0 service calls keymaster::ConfigureDevice() once at
# startup, which sends KM_TAG_OS_VERSION and KM_TAG_OS_PATCHLEVEL to the
# TrustZone app; the values come from ro.build.version.release and
# ro.build.version.security_patch. The TA binds these to every key blob, so a
# recovery that reports Android 12 / 2022-04-05 cannot use keys created by the
# installed ROM (Android 13, patch 2024-08-05 - see the recovery log:
# "Custom ROM (SDK:33, Android 13) TQ3A.230901.001").
#
# prepdecrypt.sh normally patches these props at runtime, but only if resetprop
# is present and the script gets that far; setting them at build time makes the
# match unconditional. These must be exported here (not in BoardConfig.mk):
# version_defaults.mk is read before BoardConfig.mk and marks both variables
# .KATI_READONLY, so an assignment in BoardConfig.mk would break the build,
# while an environment variable is honoured by its "ifndef" guards.
export PLATFORM_VERSION=13
export PLATFORM_SECURITY_PATCH=2024-08-05

# Add lunch combos
add_lunch_combo fox_jason-eng
add_lunch_combo fox_jason-userdebug
add_lunch_combo twrp_jason-eng
add_lunch_combo twrp_jason-userdebug
