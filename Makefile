INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = callhud3
ARCHS = arm64 arm64e
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 12.0

callhud3_FILES = tweak.xm MRYIPCCenter.m
callhud3_CFLAGS = -fobjc-arc
callhud3_FRAMEWORKS = UIKit Foundation
callhud3_PivateFrameworks = TelephonyUtilities
SUBPROJECTS += incallservicehook
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk
