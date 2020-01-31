INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = callhud3

callhud3_FILES = tweak.xm
callhud3_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
