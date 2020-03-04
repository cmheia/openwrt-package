#
# Copyright (C) 2020 MingHao Chen <cmheia@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=microsocks
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rofl0r/microsocks
PKG_SOURCE_DATE:=2019-04-09
PKG_SOURCE_VERSION:=be545814aeca1158ae38e2d6c66b1197679dab63
PKG_MIRROR_HASH:=0b9e7c71157955b58dab4beb47ebec71472490cd8b3961069d22b56cc1785378

PKG_MAINTAINER:=MingHao Chen <cmheia@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:rofl0r:microsocks

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	DEPENDS:=+libpthread
	TITLE:=multithreaded, small, efficient SOCKS5 server
	URL:=https://github.com/rofl0r/microsocks
	DEPENDS:=+libpthread
endef

define Package/$(PKG_NAME)/description
	a SOCKS5 service that you can run on your remote boxes \
	to tunnel connections through them, \
	if for some reason SSH doesn't cut it for you.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

