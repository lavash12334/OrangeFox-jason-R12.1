#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm660
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno512

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
TARGET_CPU_ABI_LIST_64_BIT := arm64-v8a
TARGET_CPU_ABI_LIST_32_BIT := armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_64_BIT),$(TARGET_CPU_ABI_LIST_32_BIT)

# Crypto
TW_INCLUDE_CRYPTO := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc170000 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=1 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 androidboot.selinux=permissive
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
BOARD_MKBOOTIMG_ARGS     := --header_version 1 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000
TARGET_PREBUILT_KERNEL := device/xiaomi/jason/Image.gz-dtb

# Partitions
BOARD_ROOT_EXTRA_FOLDERS := sys/fs/pstore
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_CACHEIMAGE_PARTITION_SIZE := 0x10000000
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x140000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 55155064320 # 55155080704 - 16384
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4

# Display & Geometry
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920

# FBE Decryption (Android 12/13/14 Fixes for Kernel 4.19)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 2

# Dynamic System Keymaster
TW_CRYPTO_USE_SYSTEM_KEYMASTER := true

# Enable Keymaster 4.0/4.1 hardware API for Kernel 4.19
OF_KEYMASTER_VERSION := 4.0
TW_KEYMASTER_MAX_API := 4.1

TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard"

# Recovery Configuration & Brightness
BOARD_HAS_NO_REAL_SDCARD := true
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 4095
TW_DEFAULT_BRIGHTNESS := 2048
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/battery

# Закомментировано, чтобы вернуть штатную инициализацию USB для MTP
# TW_EXCLUDE_DEFAULT_USB_INIT := true

TW_EXTRA_LANGUAGES := false
TW_INCLUDE_NTFS_3G := true
TW_IGNORE_MISC_WIPE_DATA := true
TW_NO_LEGACY_MISC_COMMAND := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_SCREEN_BLANK_ON_BOOT := true
TW_USE_TOOLBOX := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
