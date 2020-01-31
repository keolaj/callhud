INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = callhud3
ARCHS = arm64 arm64e
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 12.0

callhud3_FILES = tweak.xm
callhud3_CFLAGS = -fobjc-arc
callhud3_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
