.PHONY: android windows linux common

ANDROID_CONFDIR ?= /sdcard/rime/
WIN_CONFDIR := /c/Users/wsxq2/AppData/Roaming/Rime
LINUX_CONFDIR := $(HOME)/.config/ibus/rime/
adb ?= $(HOME)/Downloads/platform-tools_r33.0.3-windows/platform-tools/adb

CONFIG_FILES = $(wildcard config/*.yaml config/*.lua config/*.txt)
WUBI_CONFIG_FILES = $(wildcard config/wubi/*.yaml)
PINYIN_CONFIG_FILES = $(wildcard config/pinyin/*.yaml)
ANDROID_FILES = $(wildcard android/*)
WINDOWS_FILES := $(wildcard windows/*)

CP=cp

common:
	git submodule update --init

linux: common
	[[ -d $(LINUX_CONFDIR) ]] || mkdir -p $(LINUX_CONFDIR)
	$(CP) $(CONFIG_FILES) $(LINUX_CONFDIR)
	$(CP) $(WUBI_CONFIG_FILES) $(LINUX_CONFDIR)
	$(CP) $(PINYIN_CONFIG_FILES) $(LINUX_CONFDIR)

windows: common
	$(CP) $(CONFIG_FILES) $(WIN_CONFDIR)
	$(CP) $(WUBI_CONFIG_FILES) $(WIN_CONFDIR)
	$(CP) $(PINYIN_CONFIG_FILES) $(WIN_CONFDIR)
	$(CP) $(WINDOWS_FILES) $(WIN_CONFDIR)

android: common
	#$(adb) push $(CONFIG_FILES) $(ANDROID_CONFDIR)
	#$(adb) push $(ANDROID_FILES) $(ANDROID_CONFDIR)
	$(CP) $(CONFIG_FILES) $(ANDROID_CONFDIR)
	$(CP) $(ANDROID_FILES) $(ANDROID_CONFDIR)
	$(CP) $(WUBI_CONFIG_FILES) $(ANDROID_CONFDIR)
	$(CP) $(PINYIN_CONFIG_FILES) $(ANDROID_CONFDIR)

