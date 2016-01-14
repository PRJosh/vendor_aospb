PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aospb/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aospb/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aospb/prebuilt/common/bin/50-aospb.sh:system/addon.d/50-aospb.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/aospb/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# AOSPB-specific init file
PRODUCT_COPY_FILES += \
    vendor/aospb/prebuilt/common/etc/init.local.rc:root/init.aospb.rc

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

PRODUCT_COPY_FILES += \
    vendor/aospb/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aospb/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/aospb/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Development \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    LatinIME \
    BluetoothExt

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/aospb/overlay/common

# Versioning System
PRODUCT_VERSION_MAJOR = 6.0.1
PRODUCT_VERSION_MINOR = alpha
PRODUCT_VERSION_MAINTENANCE = 0.1
ifdef AOSPB_BUILD_EXTRA
    AOSPB_POSTFIX := -$(AOSPB_BUILD_EXTRA)
endif
ifndef AOSPB_BUILD_TYPE
    AOSPB_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif

ifeq ($(AOSPB_BUILD_TYPE),DM)
    AOSPB_POSTFIX := -$(shell date +"%Y%m%d")
endif

ifndef AOSPB_POSTFIX
    AOSPB_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

PLATFORM_VERSION_CODENAME := $(AOSPB_BUILD_TYPE)

# Set all versions
AOSPB_VERSION := AOSPB-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPB_BUILD_TYPE)$(AOSPB_POSTFIX)
AOSPB_MOD_VERSION := AOSPB-$(AOSPB_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPB_BUILD_TYPE)$(AOSPB_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.aospb.version=$(AOSPB_VERSION) \
    ro.modversion=$(AOSPB_MOD_VERSION) \
    ro.aospb.buildtype=$(AOSPB_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/aospb/tools/process_props.py

