include $(TOPDIR)/rules.mk

LUAJIT_VERSION:=2.1.0-beta3

PKG_NAME:=luajit
PKG_SOURCE_DATE:=2020-05-08-322db02
PKG_VERSION:=$(LUAJIT_VERSION)-$(PKG_SOURCE_DATE)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/LuaJIT/LuaJIT.git
PKG_SOURCE_VERSION:=322db0208160169cbfcd6cc2f93d5e0dfcb2081e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_MIRROR_HASH:=eb19df78d3e4fa3c85376cd9124e4b5fadb8e8369e3a81c86cd0c6dc096982e8

PKG_MAINTAINER:=Morteza Milani <milani@pichak.co>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYRIGHT

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/luajit
 SUBMENU:=Lua
 SECTION:=lang
 CATEGORY:=Languages
 TITLE:=LuaJIT
 URL:=https://www.luajit.org
 DEPENDS:=@(i386||x86_64||arm||armeb||aarch64||powerpc||mips||mipsel||mips64)
endef

define Package/luajit/description
 LuaJIT is a Just-In-Time (JIT) compiler for the Lua programming language. *** Requires GCC Multilib on host system to build! ***
endef
ifeq ($(HOST_ARCH),$(filter $(HOST_ARCH), x86_64 mips64))
  ifeq ($(CONFIG_ARCH_64BIT),)
    HOST_BITS := -m32
  endif
endif

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		HOST_CC="$(HOSTCC) $(HOST_CFLAGS) $(HOST_BITS)" \
		CROSS="$(TARGET_CROSS)" \
		TARGET_SYS=Linux \
		DPREFIX=$(PKG_INSTALL_DIR)/usr \
		PREFIX=/usr \
		TARGET_SYS=Linux \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" \
		BUILDMODE=dynamic
	rm -rf $(PKG_INSTALL_DIR)
	mkdir -p $(PKG_INSTALL_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR) \
		TARGET_SYS=Linux \
		DPREFIX=$(PKG_INSTALL_DIR)/usr \
		PREFIX=/usr \
		TARGET_SYS=Linux \
		install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/luajit-2.1
	$(CP) $(PKG_INSTALL_DIR)/usr/include/luajit-2.1/*.{h,hpp} $(1)/usr/include/luajit-2.1
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/luajit.pc $(1)/usr/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/luajit-$(LUAJIT_VERSION) $(PKG_INSTALL_DIR)/usr/bin/$(PKG_NAME)
endef

define Package/luajit/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so.* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share/luajit-2.1.0-beta3/jit
	$(CP) $(PKG_INSTALL_DIR)/usr/share/luajit-2.1.0-beta3/jit/*.lua $(1)/usr/share/luajit-2.1.0-beta3/jit
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/luajit-$(LUAJIT_VERSION) $(1)/usr/bin/$(PKG_NAME)
endef

define Host/Compile
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) \
		DPREFIX=$(STAGING_DIR_HOSTPKG) \
		TARGET_CFLAGS="$(HOST_CFLAGS)" \
		TARGET_LDFLAGS="$(HOST_LDFLAGS)"
endef

define Host/Install
	$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) \
		DPREFIX=$(STAGING_DIR_HOSTPKG) \
		install
	$(CP) $(STAGING_DIR_HOSTPKG)/bin/luajit-$(LUAJIT_VERSION) $(STAGING_DIR_HOSTPKG)/bin/$(PKG_NAME)
endef

$(eval $(call HostBuild,luajit))
$(eval $(call BuildPackage,luajit))
