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
# Ramdisk compression: LZMA, verified on the device. The kernel we ship is the
# ROM's 4.4 one and its embedded config has CONFIG_RD_LZMA=y (the old 4.19 kernel
# had only CONFIG_RD_GZIP/CONFIG_RD_LZ4, which is why this used to be off).
# Measured: 20 390 676 bytes with gzip -> 13 236 246 with LZMA, i.e. about 7 MB
# of headroom against the 20 447 232-byte limit. OF_USE_LZMA_COMPRESSION=1 makes
# orangefox.mk set BOARD_RAMDISK_USE_LZMA, which TWRP's build/make fork turns
# into "lzma -f -c". If a future kernel cannot decompress it, the recovery dies
# silently before anything is logged - revert this one line then.
export OF_USE_LZMA_COMPRESSION=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_REPLACE_BUSYBOX_PS=0
# Python is still excluded: it is the single biggest item in the ramdisk and
# nothing here needs it.
export TW_EXCLUDE_PYTHON=true

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

# Flashlight. PM660L device with a dual-tone flash behind one enable switch,
# verified by writing to the sysfs nodes on the device:
#   led:torch_0 -> the warm (amber) LED
#   led:torch_1 -> the white LED        <- this is the one we use
#   led:switch_0 -> the enable for both (led:switch_1 does nothing here)
# Lighting both LEDs at once needs three writes and OrangeFox only takes two
# paths (level, then enable), so the flashlight is the white LED alone.
export OF_FLASHLIGHT_ENABLE=1
export OF_FL_PATH1="/sys/class/leds/led:torch_1/brightness"
export OF_FL_PATH2="/sys/class/leds/led:switch_0/brightness"

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
# prepdecrypt.sh can also patch these props at runtime, but the known-working
# FBE recovery for this device does not rely on that: TWRP 3.7.0_11-0-jason-FBE
# (4PDA, decrypts /data of Android 11 ROMs on this phone) ships
# ro.build.version.release=11 and ro.build.version.security_patch=2099-12-31 in
# its prop.default and leaves prepdecrypt's SETPATCH at false. A patch level in
# the far future is the safe direction: the TA then asks for a key upgrade
# instead of refusing a key that is newer than the device, and the vendor HAL
# does implement upgrade_key. The OS version is set to the ROM's actual value
# (Android 13) because that one is known exactly.
#
# Both must be exported here rather than set in BoardConfig.mk:
# version_defaults.mk is read first (envsetup.mk includes it before
# board_config.mk) and marks them .KATI_READONLY, so an assignment in
# BoardConfig.mk breaks the build, while an environment variable is picked up by
# their "ifndef" guards.
export PLATFORM_VERSION=13
export PLATFORM_SECURITY_PATCH=2099-12-31

# Add lunch combos
add_lunch_combo fox_jason-eng
add_lunch_combo fox_jason-userdebug
add_lunch_combo twrp_jason-eng
add_lunch_combo twrp_jason-userdebug
