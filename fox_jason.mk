#
# Copyright (C) 2026 The OrangeFox Recovery Project
#

PRODUCT_RELEASE_NAME := jason

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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/lib64/libQSEEComAPI.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libQSEEComAPI.so \
    $(LOCAL_PATH)/proprietary/lib64/libdiag.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdiag.so \
    $(LOCAL_PATH)/proprietary/lib64/libdrmfs.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdrmfs.so \
    $(LOCAL_PATH)/proprietary/lib64/librpmb.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librpmb.so \
    $(LOCAL_PATH)/proprietary/lib64/libssd.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libssd.so \
    $(LOCAL_PATH)/proprietary/lib64/hw/keystore.sdm660.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/keystore.sdm660.so

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
