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

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

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
TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/commonsys/cryptfs_hw
TARGET_HW_DISK_ENCRYPTION := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc170000 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=1 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 androidboot.selinux=permissive
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_MKBOOTIMG_ARGS     := --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_PREBUILT_KERNEL := device/xiaomi/jason/Image.gz-dtb

# Partitions
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_CACHEIMAGE_PARTITION_SIZE := 0x10000000
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x140000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 55155064320 # 55155080704 - 16384
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_USERIMAGES_USE_EXT4 := true

# OrangeFox R12.1 Build Configuration
FOX_BUILD_TYPE := Unofficial
FOX_MAINTAINER_PATCH_VERSION := 1
OF_MAINTAINER := "Kirill & Antigravity"
FOX_MAINTAINER := "Kirill & Antigravity"
FOX_BUILD_DEVICE := jason
FOX_TARGET_DEVICES := jason

# OrangeFox R12.1 Options & Patches
OF_USE_MAGISKBOOT := 1
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_DONT_PATCH_ENCRYPTION := 1
OF_SKIP_MULTIUSER := 1
OF_USE_HEX_OPTIMLIBS := 1
OF_VANILLA_BUILD := 0

# Display & Geometry (Mi Note 3: 1080x1920, 16:9, capacitive keys)
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920
OF_SCREEN_H := 1920
OF_STATUS_H := 80
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_ALLOW_DISABLE_NAVBAR := 0

# FBE Decryption (Android 13 / crDroid 13 / SDM660)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 2

# Recovery Configuration & Brightness
BOARD_HAS_NO_REAL_SDCARD := true
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 160
OF_CLOCK_POS := 1
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := false
TW_INCLUDE_NTFS_3G := true
TW_IGNORE_MISC_WIPE_DATA := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_SCREEN_BLANK_ON_BOOT := true
TW_USE_TOOLBOX := true
TARGET_USES_LOGD := false
