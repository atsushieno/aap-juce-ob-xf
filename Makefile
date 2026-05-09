
PWD=$(shell pwd)
AAP_JUCE_DIR=$(PWD)/external/aap-juce

# Specify the app name. It will show up as the Main Launcher.
APP_NAME=OB-Xf

APP_BUILD_DIR=$(PWD)
# Specify the app repo as a submodule
APP_SRC_DIR=$(PWD)/external/OB-Xf
# Typical JUCE app submodules JUCE, but the location is up to the project.
JUCE_DIR=$(APP_SRC_DIR)/libs/JUCE

APP_ICON=$(APP_SRC_DIR)/external/OB-Xf/assets/icon.svg

APP_SHARED_CODE_LIBS="$(APP_NAME)_artefacts/lib$(APP_NAME)_SharedCode.a"

# It can be any name, just make sure you generate the diff for AAP support,
# otherwise it will only build for Android without AAP.
# Make sure to include submodule changes (by e.g. git diff --submodule=diff)
PATCH_FILE=$(PWD)/aap-juce-support.patch

# JUCE patches if any
JUCE_PATCHES= \
	$(AAP_JUCE_DIR)/juce-patches/7.0.6/support-plugin-ui.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/juce-component-peer-view-touch.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/embedded-peer-window-guard.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/popup-menu-android.patch
JUCE_PATCH_DEPTH=1


include $(AAP_JUCE_DIR)/Makefile.cmake-common
