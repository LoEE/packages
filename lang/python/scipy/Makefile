#
# Copyright (C) 2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=scipy
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE:=scipy-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/scipy/scipy/releases/download/v1.3.1/
PKG_HASH:=326ffdad79f113659ed0bca80f5d0ed5e28b2e967b438bb1f647d0738073a92e

PKG_BUILD_DEPENDS:=numpy/host

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-scipy-$(PKG_VERSION)/scipy-$(PKG_VERSION)

PKG_LICENSE:=BSD License
PKG_LICENSE_FILES:=LICENSE.txt LICENSES_bundled.txt

include $(INCLUDE_DIR)/package.mk
include ../python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(BUILD_DIR)/$(BUILD_VARIANT)-scipy-$(PKG_VERSION) -xzf $(DL_DIR)/$(PKG_SOURCE)

# TARGET_LDFLAGS:=$(filter-out -znow -zrelro,$(TARGET_LDFLAGS))

define Package/python3-scipy-ndimage
  SECTION:=lang-python
  CATEGORY:=Languages
  SUBMENU:=Python
  URL:=https://www.scipy.org/
  TITLE:=python3-scipy-ndimage
  DEPENDS:=+PACKAGE_python3-scipy-ndimage:python3 python3-numpy
  VARIANT:=python3
endef

define Package/python3-scipy-ndimage/description
scipy contains routines for numerical integration, interpolation,
optimization, linear algebra and statistics for numpy.
.
(Variant for Python3)
endef


define Py3Build/Compile
  cd $(PKG_BUILD_DIR)/scipy/ndimage
	$(call Build/Compile/Py3Mod,,\
		install --prefix=/usr --root=$(PKG_INSTALL_DIR),\
    TARGET_PLATFORM=linux\
	)
endef

$(eval $(call Py3Package,python3-scipy-ndimage))
$(eval $(call BuildPackage,python3-scipy-ndimage))
$(eval $(call BuildPackage,python3-scipy-ndimage-src))
