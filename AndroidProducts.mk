#
# Copyright (C) 2026 The OrangeFox / TWRP Recovery Project
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_jason.mk \
    $(LOCAL_DIR)/fox_jason.mk \
    $(LOCAL_DIR)/omni_jason.mk

COMMON_LUNCH_CHOICES := \
    twrp_jason-eng \
    twrp_jason-userdebug \
    fox_jason-eng \
    fox_jason-userdebug \
    omni_jason-eng \
    omni_jason-userdebug
