include $(TOPDIR)/rules.mk

PKG_NAME:=3proxy
PKG_VERSION=0.8.13
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/z3APA3A/3proxy/tar.gz/$(PKG_VERSION)?
PKG_HASH:=a6d3cf9dd264315fa6ec848f6fe6c9057db005ce4ca8ed1deb00f6e1c3900f88

PKG_MAINTAINER:=MingHao Chen <cmheia@gmail.com>
PKG_LICENSE:=BSD-3-clause Apache-2.0 GPL-2.0-or-later LGPL-2.1-or-later
PKG_LICENSE_FILES:=copying
PKG_CPE_ID:=cpe:/a:vladimir_dubrovin:3proxy

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=tiny free proxy server
	URL:=https://github.com/z3APA3A/3proxy
	DEPENDS:=+libpthread +libopenssl
endef

define Package/$(PKG_NAME)/description
	3APA3A 3proxy tiny proxy server
endef

define Package/3proxy/conffiles
	/etc/3proxy/3proxy.cfg
endef

define Build/Configure
	$(CP) $(PKG_BUILD_DIR)/Makefile.Linux $(PKG_BUILD_DIR)/Makefile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/src/{3proxy,dighosts,ftppr,mycrypt,pop3p,proxy,socks,tcppm,udppm} \
		$(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/add3proxyuser.sh $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/3proxy
	$(INSTALL_CONF) files/3proxy.cfg $(1)/etc/3proxy
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/3proxy.init $(1)/etc/init.d/3proxy
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

