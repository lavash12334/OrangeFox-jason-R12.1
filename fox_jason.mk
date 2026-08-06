#
# Copyright (C) 2026 The OrangeFox Recovery Project
#

PRODUCT_RELEASE_NAME := jason

$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)

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
    $(LOCAL_PATH)/proprietary/lib64/hw/keystore.sdm660.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/keystore.sdm660.so \
    $(LOCAL_PATH)/proprietary/etc/hid/consumer-desc.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/hid/consumer-desc.bin \
    $(LOCAL_PATH)/proprietary/etc/hid/keyboard-desc.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/hid/keyboard-desc.bin \
    $(LOCAL_PATH)/proprietary/etc/hid/mouse-desc.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/hid/mouse-desc.bin

PRODUCT_NAME := fox_jason
PRODUCT_DEVICE := jason
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Mi Note 3

TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920
TW_THEME := portrait_hdpi

TARGET_VENDOR_PRODUCT_NAME := jason
TARGET_VENDOR_DEVICE_NAME := jason
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=jason PRODUCT_NAME=jason
