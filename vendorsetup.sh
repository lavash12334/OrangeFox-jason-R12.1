#
# Copyright (C) 2026 The OrangeFox Recovery Project
#

export FOX_BUILD_TYPE="Unofficial"
export FOX_MAINTAINER_PATCH_VERSION="1"
export OF_MAINTAINER="Kirill & Antigravity"
export FOX_MAINTAINER="Kirill & Antigravity"
export FOX_BUILD_DEVICE="jason"
export FOX_TARGET_DEVICES="jason"

# OrangeFox Options & Features
export FOX_USE_LZMA_COMPRESSION=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_REPLACE_BUSYBOX_PS=1
export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_SED_BINARY=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_XZ_UTILS=1

export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_DONT_PATCH_ENCRYPTION=1
export OF_SKIP_MULTIUSER=1
export OF_USE_HEX_OPTIMLIBS=1
export OF_VANILLA_BUILD=0

# Display & UI Geometry (Mi Note 3: 1080x1920, HDPI)
export TARGET_SCREEN_WIDTH=1080
export TARGET_SCREEN_HEIGHT=1920
export OF_SCREEN_H=1920
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_ALLOW_DISABLE_NAVBAR=0
export OF_CLOCK_POS=1

# FBE Decryption & Storage
export TW_INCLUDE_CRYPTO=true
export TW_INCLUDE_FBE=true
export TW_INCLUDE_FBE_METADATA_DECRYPT=true
export BOARD_USES_QCOM_FBE_DECRYPTION=true
export TW_USE_FSCRYPT_POLICY=2
export RECOVERY_SDCARD_ON_DATA=true

# Add lunch combos
add_lunch_combo fox_jason-eng
add_lunch_combo fox_jason-userdebug
add_lunch_combo twrp_jason-eng
add_lunch_combo twrp_jason-userdebug
