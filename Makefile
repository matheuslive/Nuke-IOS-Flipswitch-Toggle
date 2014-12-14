include theos/makefiles/common.mk

BUNDLE_NAME = nuke
nuke_FILES = Switch.x
nuke_FRAMEWORKS = UIKit
nuke_LIBRARIES = flipswitch
nuke_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
