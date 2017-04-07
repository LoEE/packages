#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/python-json
$(call Package/python/Default)
  TITLE:=Python $(PYTHON_VERSION) json module
  DEPENDS:=+python-light
endef

$(eval $(call PyBasePackage,python-json, \
	/usr/lib/python$(PYTHON_VERSION)/json \
))
