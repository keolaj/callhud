INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = incallservicehook
ARCHS = arm64 arm64e
TARGET = iphone:clang::12.0
incallservicehook_PrivateFrameworks = InCallService
incallservicehook_FILES = Tweak.x MRYIPCCenter.m
incallservicehook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
