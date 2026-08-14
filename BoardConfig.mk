#
# Copyright (C) 2017 The Android Open Source Project
# Copyright (C) 2019-2026 The OrangeFox Recovery Project
#

DEVICE_PATH := device/xiaomi/jason

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm660
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno512
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# Assert
TARGET_OTA_ASSERT_DEVICE := jason,jason_sp

# Kernel: the ROM's own kernel, extracted from its boot partition
# (4.4.302-perf-g2c13c8fc3723, built 2024-08-15).
#
# This MUST stay a 4.4 kernel. The vendor decryption stack on this device is
# from Android 8.1 (qseecomd, android.hardware.keymaster@3.0-service,
# keystore.sdm660.so, libQSEEComAPI.so) and it does not work on the 4.19
# LineageOS kernel we used before: with 4.19 the TrustZone app answers version
# queries but rejects *every* key operation with -8 (verified with
# keystore_cli_v2: RSA, EC, AES, AES-GCM and HMAC key generation all failed),
# so /data could never be decrypted. With this kernel the same binaries work
# and decryption succeeds. Do not swap in the 4.19 kernel again.
#
# The Flybustier 4.4 kernel from the third-party FBE TWRP is not usable either:
# it cannot mount this /data read-write ("unsupported optional features (2000)"
# = ext4 RO_COMPAT_PROJECT, the project quotas the ROM uses).
#
# Command line: taken verbatim from the third-party FBE TWRP for jason, which is
# the combination validated on the device. Unlike the 4.19 kernel this one does
# have the UART driver, so the console arguments are useful.
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += earlycon=msm_serial_dm,0xc170000 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 sched_enable_hmp=1
BOARD_KERNEL_CMDLINE += sched_enable_power_aware=1 service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048 androidboot.usbcontroller=a800000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.configfs=true androidboot.selinux=permissive
# buildvariant is not listed here on purpose: the build system appends
# "buildvariant=eng" itself, and having it in both places put it in the image
# twice (visible in "magiskboot unpack -h").

BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_ARCH := arm64
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/Image.gz-dtb

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_CACHEIMAGE_PARTITION_SIZE := 0x10000000
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x140000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 55155064320
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Display & Geometry
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
# BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_SDCARD_ON_DATA := true

# FBE Decryption (Android 12/13/14 Fixes for Kernel 4.19)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 1

# Keymaster: this device only has the vendor keymaster 3.0 HAL (keymaster1
# implementation, /vendor/lib64/hw/keystore.sdm660.so). Force it instead of
# relying on the VINTF lookup, and disable the 4.x paths.
# These three names are the ones the OrangeFox 12.1 sources actually read
# (orangefox.mk: OF_DEFAULT_KEYMASTER_VERSION, TW_FORCE_KEYMASTER_VER,
# OF_NO_KEYMASTER_VER_4X).
OF_DEFAULT_KEYMASTER_VERSION := 3.0
TW_FORCE_KEYMASTER_VER := true
OF_NO_KEYMASTER_VER_4X := 1
# Kept for documentation only: no reference to TW_CRYPTO_USE_SYSTEM_KEYMASTER,
# OF_KEYMASTER_VERSION or TW_KEYMASTER_MAX_API exists in orangefox.mk,
# bootable/recovery/Android.mk or the vold fork's Android.bp of this branch.
# TW_CRYPTO_USE_SYSTEM_KEYMASTER := true
# OF_KEYMASTER_VERSION := 3.0
# TW_KEYMASTER_MAX_API := 3.0

TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard"

# Recovery Configuration & Brightness
BOARD_HAS_NO_REAL_SDCARD := true
TW_THEME := portrait_hdpi
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 4095
TW_DEFAULT_BRIGHTNESS := 2048
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/battery

TW_EXTRA_LANGUAGES := true
TW_EXCLUDE_APEX := true
TW_EXCLUDE_PYTHON := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRP_APP := true
# MTP is enabled. Two reasons: OrangeFox's ground rules expect a complete
# recovery, and - more importantly - excluding it made partitionmanager.cpp fail
# to compile (it uses AID_MEDIA_RW, whose declaration only reaches it through the
# MTP includes), which we used to work around by patching the OrangeFox sources
# in CI. Official maintainers may not modify the sources, so the patch is gone
# and MTP is in. init.recovery.qcom.rc has the matching mtp / mtp,adb gadget
# handlers.
TW_INCLUDE_NTFS_3G := true
TW_IGNORE_MISC_WIPE_DATA := true
TW_NO_LEGACY_MISC_COMMAND := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_NO_LEGACY_PROPS := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_USE_TOOLBOX := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

ALLOW_MISSING_DEPENDENCIES := true
SOONG_ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true
