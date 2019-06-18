#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=runit
PKG_VERSION:=2.1.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/MarketLab/runit.git
PKG_SOURCE_VERSION:=75199802b69420578a9a84c7dad9c5c9c2e0415f

include $(INCLUDE_DIR)/package.mk

define Package/runit
	SECTION:=admin
	CATEGORY:=Administration
	TITLE:=runit process supervisor
	DEPENDS:=+libc
	URL:=http://smarden.org/runit/
	MAINTAINER:=Jakub Piotr Cłapa <jpc@loee.pl>
endef

define Package/runit/description
	runit is a process supervisor similar to djb's daemontools. It contains tools for
	supervision, log collection and rotation.
endef

define Build/Compile
	echo "$(TARGET_CC) $(TARGET_CFLAGS)" > $(PKG_BUILD_DIR)/src/conf-cc
	echo "$(TARGET_CC) $(TARGET_LDFLAGS)" > $(PKG_BUILD_DIR)/src/conf-ld
	# we cannot run any crosscompiled code so we hardcode the results of some tests
	# the results will be valid for any Linux host (and probably any other modern UNIX)

	# this is needed so the overrides we add below are considered fresh by make
	(cd $(PKG_BUILD_DIR)/src; make compile load chkshsgr choose makelib)

	cp $(PKG_BUILD_DIR)/src/uint64.h1 $(PKG_BUILD_DIR)/src/uint64.h
	cp $(PKG_BUILD_DIR)/src/hasshsgr.h1 $(PKG_BUILD_DIR)/src/hasshsgr.h
	cp $(PKG_BUILD_DIR)/src/iopause.h1 $(PKG_BUILD_DIR)/src/iopause.h
	cp $(PKG_BUILD_DIR)/src/hasshsgr.h1 $(PKG_BUILD_DIR)/src/hasshsgr.h

	# override makelib to use the cross-ar
	rm -f $(PKG_BUILD_DIR)/src/makelib
	echo 'rm -f "$$$$1" && $(TARGET_AR) cr "$$$$@"' > $(PKG_BUILD_DIR)/src/makelib
	chmod 555 $(PKG_BUILD_DIR)/src/makelib
	(cd $(PKG_BUILD_DIR)/src; make)
endef

define Package/runit/install
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_BUILD_DIR)/src/chpst $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/runit $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/runit-init $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/runsv $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/runsvchdir $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/runsvdir $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/sv $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/svlogd $(1)/bin/
	$(CP) $(PKG_BUILD_DIR)/src/utmpset $(1)/bin/
endef

$(eval $(call BuildPackage,runit))
