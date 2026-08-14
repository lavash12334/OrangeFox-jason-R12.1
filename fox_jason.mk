#
# Copyright (C) 2026 The OrangeFox Recovery Project
#

PRODUCT_RELEASE_NAME := jason

$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/base_system.mk)

# Inherit OrangeFox / TWRP common configs
$(call inherit-product-if-exists, vendor/fox/config/common.mk)
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)

$(call inherit-product-if-exists, vendor/fox/config/common.mk)
$(call inherit-product-if-exists, vendor/recovery/config/common.mk)
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)
$(call inherit-product-if-exists, vendor/omni/config/common.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=sdm660 \
    sys.usb.controller=a800000.dwc3 \
    sys.usb.rndis.func.name=rndis_bam \
    sys.usb.rmnet.func.name=rmnet_bam

# Decryption helpers (qseecomd/keymaster services for FBE)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# NOTE: the keymaster/qseecom blobs are NOT copied into the build. They are used
# straight from the ROM's cust partition, which init.recovery.qcom.rc mounts at
# /mnt/vendor_cust and exposes through /vendor/bin and /vendor/lib64. Copies made
# with PRODUCT_COPY_FILES into $(TARGET_COPY_OUT_VENDOR) never reach the recovery
# ramdisk, so they were dead configuration and have been removed. The reference
# copies kept in proprietary/ are what the analysis in the handover notes was
# done on. If the cust mount ever becomes a problem, the alternative is to copy
# them to $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64 instead, which is what the
# third-party FBE TWRP for this device does.

PRODUCT_NAME := fox_jason
PRODUCT_DEVICE := jason
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi Note 3

TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920
TW_THEME := portrait_hdpi

# Official OrangeFox R12.1 Build Settings (wiki.orangefox.tech)
OF_SCREEN_H := 1920
OF_STATUS_H := 40
OF_USE_GREEN_LED := 0
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_UNBIND_SDCARD_F2FS := 1
OF_QUICK_BACKUP_LIST := /boot;/data;
OF_FBE_METADATA_MOUNT_IGNORE := 1
OF_FIX_DECRYPTION_ON_DATA_MEDIA := 1
OF_DEFAULT_KEYMASTER_VERSION := 4.0
OF_PATCH_AVB20 := 1
OF_NO_ADDITIONAL_MIUI_PROPS_CHECK := 1
OF_DISABLE_OTA_MENU := 1
OF_KEEP_FORCED_ENCRYPTION := 1
OF_DONT_PATCH_ENCRYPTED_DEVICE := 1
OF_OPTIONS_LIST_NUM := 9
# OF_ENABLE_ALL_PARTITION_TOOLS is only for dynamic partition devices
OF_USE_LEGACY_TIME_FIXUP := 1
OF_ENABLE_FRP_ADDON := 1
OF_USE_DMCTL := 1

TARGET_VENDOR_PRODUCT_NAME := jason
TARGET_VENDOR_DEVICE_NAME := jason
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=jason PRODUCT_NAME=jason
