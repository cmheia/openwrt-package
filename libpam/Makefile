#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpam
PKG_VERSION:=1.3.1
PKG_RELEASE:=2

PKG_SOURCE:=Linux-PAM-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/linux-pam/linux-pam/releases/download/v$(PKG_VERSION)
PKG_HASH:=eff47a4ecd833fbf18de9686632a70ee8d0794b79aecb217ebd0ce11db4cd0db
PKG_SOURCE_SUBDIR:=Linux-PAM-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_SOURCE_SUBDIR)

PKG_MAINTAINER:=Nikos Mavrogiannopoulos <n.mavrogiannopoulos@gmail.com>, MingHao Chen <cmheia@gmail.com>
PKG_LICENSE:=BSD-3c GPL
PKG_LICENSE_FILES:=COPYING Copyright
PKG_CPE_ID:=cpe:/a:kernel:linux-pam

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=the Linux-PAM libraries and modules.$(2)
  URL:=http://www.kernel.org/pub/linux/libs/pam
  VARIANT:=$(1)
  DEPENDS:=$(3)
  PROVIDES:=$(PKG_NAME)
endef

Package/$(PKG_NAME)-default=$(call Package/$(PKG_NAME)/Default,default,,)
Package/$(PKG_NAME)-db=$(call Package/$(PKG_NAME)/Default,db,(db support),+libdb47)

define Package/$(PKG_NAME)/description/Default
	The Linux-PAM Pluggable Authentication Modules.$(1)
endef

Package/$(PKG_NAME)-default/description=$(call Package/$(PKG_NAME)/description/Default,)
Package/$(PKG_NAME)-db/description=$(call Package/$(PKG_NAME)/description/Default,(db support))

ifeq ($(BUILD_VARIANT),db)
CONFIGURE_ARGS += \
	--enable-pamlocking \
	--enable-shared \
	--enable-static \
	--disable-audit \
	--disable-cracklib \
	--enable-db \
	--disable-prelude \
	--disable-lckpwdf \
	--disable-nis \
	--disable-regenerate-docu \
	--disable-rpath \
	--disable-selinux \
	--with-gnu-ld \
	--without-mailspool \
	--without-xauth
else
CONFIGURE_ARGS += \
	--enable-pamlocking \
	--enable-shared \
	--enable-static \
	--disable-audit \
	--disable-cracklib \
	--disable-db \
	--disable-prelude \
	--disable-lckpwdf \
	--disable-nis \
	--disable-regenerate-docu \
	--disable-rpath \
	--disable-selinux \
	--with-gnu-ld \
	--without-mailspool \
	--without-xauth
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/lib/* $(1)/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/lib $(1)/lib/security $(1)/lib/security/pam_filter
	$(INSTALL_DIR) $(1)/etc $(1)/etc/pam.d
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/lib/*.so* $(1)/lib/
	$(CP) $(PKG_INSTALL_DIR)/lib/security/*.so* $(1)/lib/security/
	$(CP) $(PKG_INSTALL_DIR)/lib/security/pam_filter/* $(1)/lib/security/pam_filter/
	$(CP) $(PKG_INSTALL_DIR)/etc/* $(1)/etc/
	$(CP) ./files/* $(1)/etc/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/* $(1)/usr/sbin/
endef

Package/$(PKG_NAME)-default/install=$(Package/$(PKG_NAME)/install)
Package/$(PKG_NAME)-db/install=$(Package/$(PKG_NAME)/install)

$(eval $(call BuildPackage,$(PKG_NAME)-default))
$(eval $(call BuildPackage,$(PKG_NAME)-db))
