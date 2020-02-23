#
# Copyright (C) 2012-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nginx
PKG_VERSION:=1.17.8
PKG_RELEASE:=1

PKG_SOURCE:=nginx-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://nginx.org/download/
PKG_HASH:=97d23ecf6d5150b30e284b40e8a6f7e3bb5be6b601e373a4d013768d5a25965b

PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de> \
				Ansuel Smith <ansuelsmth@gmail.com> \
				MingHao Chen <cmheia@gmail.com>
PKG_LICENSE:=2-clause BSD-like license
PKG_CPE_ID:=cpe:/a:nginx:nginx

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS := \
	CONFIG_NGINX_SSL \
	CONFIG_NGINX_DAV \
	CONFIG_NGINX_FLV \
	CONFIG_NGINX_UBUS \
	CONFIG_NGINX_STUB_STATUS \
	CONFIG_NGINX_HTTP_CHARSET \
	CONFIG_NGINX_HTTP_GZIP \
	CONFIG_NGINX_HTTP_SSI \
	CONFIG_NGINX_HTTP_USERID \
	CONFIG_NGINX_HTTP_ACCESS \
	CONFIG_NGINX_HTTP_AUTH_BASIC \
	CONFIG_NGINX_HTTP_AUTH_REQUEST \
	CONFIG_NGINX_HTTP_AUTOINDEX \
	CONFIG_NGINX_HTTP_GEO \
	CONFIG_NGINX_HTTP_MAP \
	CONFIG_NGINX_HTTP_SPLIT_CLIENTS \
	CONFIG_NGINX_HTTP_REFERER \
	CONFIG_NGINX_HTTP_REWRITE \
	CONFIG_NGINX_HTTP_PROXY \
	CONFIG_NGINX_HTTP_FASTCGI \
	CONFIG_NGINX_HTTP_UWSGI \
	CONFIG_NGINX_HTTP_SCGI \
	CONFIG_NGINX_HTTP_MEMCACHED \
	CONFIG_NGINX_HTTP_LIMIT_CONN \
	CONFIG_NGINX_HTTP_LIMIT_REQ \
	CONFIG_NGINX_HTTP_EMPTY_GIF \
	CONFIG_NGINX_HTTP_BROWSER \
	CONFIG_NGINX_HTTP_UPSTREAM_HASH \
	CONFIG_NGINX_HTTP_UPSTREAM_IP_HASH \
	CONFIG_NGINX_HTTP_UPSTREAM_LEAST_CONN \
	CONFIG_NGINX_HTTP_UPSTREAM_KEEPALIVE \
	CONFIG_NGINX_HTTP_UPSTREAM_ZONE \
	CONFIG_NGINX_HTTP_UPSTREAM_CHECK \
	CONFIG_NGINX_HTTP_CACHE \
	CONFIG_NGINX_HTTP_V2 \
	CONFIG_NGINX_HTTP_SUBSTITUTIONS_FILTER \
	CONFIG_NGINX_HTTP_XSLT \
	CONFIG_NGINX_PCRE \
	CONFIG_NGINX_NAXSI \
	CONFIG_NGINX_LUA \
	CONFIG_NGINX_HTTP_REAL_IP \
	CONFIG_NGINX_HTTP_SECURE_LINK \
	CONFIG_NGINX_HTTP_BROTLI \
	CONFIG_NGINX_HTTP_GUNZIP \
	CONFIG_NGINX_GZIP_STATIC \
	CONFIG_NGINX_HEADERS_MORE \
	CONFIG_NGINX_STREAM_CORE_MODULE \
	CONFIG_NGINX_STREAM_SSL_MODULE \
	CONFIG_NGINX_STREAM_SSL_PREREAD_MODULE \
	CONFIG_NGINX_RTMP_MODULE \
	CONFIG_NGINX_TS_MODULE \
	CONFIG_OPENSSL_ENGINE \
	CONFIG_OPENSSL_WITH_NPN

include $(INCLUDE_DIR)/package.mk

define Package/nginx/default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Nginx web server
  URL:=http://nginx.org/
  DEPENDS:=+NGINX_PCRE:libpcre +NGINX_SSL:libopenssl \
	+NGINX_HTTP_GZIP:zlib +NGINX_LUA:liblua +libpthread +NGINX_DAV:libxml2 \
	+NGINX_HTTP_XSLT:libexslt \
	+NGINX_UBUS:libubus +NGINX_UBUS:libblobmsg-json +NGINX_UBUS:libjson-c
endef

define Package/nginx/description
 nginx is an HTTP and reverse proxy server, as well as a mail proxy server, \
 written by Igor Sysoev. (Some module require SSL module enable to show up in \
 config menu)
endef

define Package/nginx
  $(Package/nginx/default)
  VARIANT:=no-ssl
endef

define Package/nginx-ssl
  $(Package/nginx/default)
  TITLE += with SSL support
  DEPENDS +=+libopenssl
  VARIANT:=ssl
  PROVIDES:=nginx
endef

Package/nginx-ssl/description = $(Package/nginx/description) \
  This variant is compiled with SSL support enabled. To enable additional module \
  select them in the nginx default configuration menu.

define Package/nginx-all-module
  $(Package/nginx/default)
  TITLE += with ALL module selected
  DEPENDS:=+libpcre +libopenssl +zlib +liblua +libpthread +libxml2 \
   +libexslt \
   +libubus +libblobmsg-json +libjson-c
  VARIANT:=all-module
  PROVIDES:=nginx
endef

Package/nginx-all-module/description = $(Package/nginx/description) \
  This variant is compiled with ALL module selected.

define Package/nginx/config
  source "$(SOURCE)/Config.in"
endef

define Package/nginx-ssl/config
  source "$(SOURCE)/Config_ssl.in"
endef

config_files=nginx.conf mime.types

define Package/nginx/conffiles
/etc/nginx/
endef

Package/nginx-ssl/conffiles = $(Package/nginx/conffiles)
Package/nginx-all-module/conffiles = $(Package/nginx/conffiles)


ADDITIONAL_MODULES:=

ifneq ($(BUILD_VARIANT),all-module)
  ifneq ($(CONFIG_NGINX_HTTP_CACHE),y)
    ADDITIONAL_MODULES += --without-http-cache
  endif
  ifneq ($(CONFIG_NGINX_PCRE),y)
    ADDITIONAL_MODULES += --without-pcre
  endif
  ifneq ($(CONFIG_NGINX_HTTP_CHARSET),y)
    ADDITIONAL_MODULES += --without-http_charset_module
  else
    config_files += koi-utf koi-win win-utf
  endif
  ifneq ($(CONFIG_NGINX_HTTP_GZIP),y)
    ADDITIONAL_MODULES += --without-http_gzip_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_SSI),y)
    ADDITIONAL_MODULES += --without-http_ssi_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_USERID),y)
    ADDITIONAL_MODULES += --without-http_userid_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_ACCESS),y)
    ADDITIONAL_MODULES += --without-http_access_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_AUTH_BASIC),y)
    ADDITIONAL_MODULES += --without-http_auth_basic_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_AUTOINDEX),y)
    ADDITIONAL_MODULES += --without-http_autoindex_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_GEO),y)
    ADDITIONAL_MODULES += --without-http_geo_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_MAP),y)
    ADDITIONAL_MODULES += --without-http_map_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_SPLIT_CLIENTS),y)
    ADDITIONAL_MODULES += --without-http_split_clients_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_REFERER),y)
    ADDITIONAL_MODULES += --without-http_referer_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_REWRITE),y)
    ADDITIONAL_MODULES += --without-http_rewrite_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_PROXY),y)
    ADDITIONAL_MODULES += --without-http_proxy_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_FASTCGI),y)
    ADDITIONAL_MODULES += --without-http_fastcgi_module
  else
    config_files += fastcgi_params
  endif
  ifneq ($(CONFIG_NGINX_HTTP_UWSGI),y)
    ADDITIONAL_MODULES += --without-http_uwsgi_module
  else
    config_files += uwsgi_params
  endif
  ifneq ($(CONFIG_NGINX_HTTP_SCGI),y)
    ADDITIONAL_MODULES += --without-http_scgi_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_MEMCACHED),y)
    ADDITIONAL_MODULES += --without-http_memcached_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_LIMIT_CONN),y)
    ADDITIONAL_MODULES += --without-http_limit_conn_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_LIMIT_REQ),y)
    ADDITIONAL_MODULES += --without-http_limit_req_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_EMPTY_GIF),y)
    ADDITIONAL_MODULES += --without-http_empty_gif_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_BROWSER),y)
    ADDITIONAL_MODULES += --without-http_browser_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_UPSTREAM_HASH),y)
    ADDITIONAL_MODULES += --without-http_upstream_hash_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_UPSTREAM_IP_HASH),y)
    ADDITIONAL_MODULES += --without-http_upstream_ip_hash_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_UPSTREAM_LEAST_CONN),y)
    ADDITIONAL_MODULES += --without-http_upstream_least_conn_module
  endif
  ifneq ($(CONFIG_NGINX_HTTP_UPSTREAM_KEEPALIVE),y)
    ADDITIONAL_MODULES += --without-http_upstream_keepalive_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_UPSTREAM_CHECK),y)
    ADDITIONAL_MODULES += --add-module=nginx-upstream-check
  endif
  
  ifeq ($(BUILD_VARIANT),ssl)
    ifneq ($(CONFIG_NGINX_SSL),y)
      ADDITIONAL_MODULES += --with-http_ssl_module
    endif
  endif
  
  ifeq ($(CONFIG_NGINX_SSL),y)
    ADDITIONAL_MODULES += --with-http_ssl_module
  endif
  ifeq ($(CONFIG_NGINX_NAXSI),y)
    ADDITIONAL_MODULES += --add-module=nginx-naxsi/naxsi_src
  endif
  ifeq ($(CONFIG_NGINX_LUA),y)
    ADDITIONAL_MODULES += --add-module=lua-nginx
  endif
  ifeq ($(CONFIG_IPV6),y)
    ADDITIONAL_MODULES += --with-ipv6
  endif
  ifeq ($(CONFIG_NGINX_STUB_STATUS),y)
    ADDITIONAL_MODULES += --with-http_stub_status_module
  endif
  ifeq ($(CONFIG_NGINX_FLV),y)
    ADDITIONAL_MODULES += --with-http_flv_module
  endif
  ifeq ($(CONFIG_NGINX_DAV),y)
    ADDITIONAL_MODULES += --with-http_dav_module --add-module=nginx-dav-ext-module
  endif
  ifeq ($(CONFIG_NGINX_UBUS),y)
    ADDITIONAL_MODULES += --add-module=nginx-ubus-module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_AUTH_REQUEST),y)
    ADDITIONAL_MODULES += --with-http_auth_request_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_V2),y)
    ADDITIONAL_MODULES += --with-http_v2_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_XSLT),y)
    ADDITIONAL_MODULES += --with-http_xslt_module
    TARGET_CPPFLAGS += -I$(STAGING_DIR)/usr/include/libxml2
  endif
  ifeq ($(CONFIG_NGINX_HTTP_GUNZIP),y)
    ADDITIONAL_MODULES += --with-http_gunzip_module
  endif
  ifeq ($(CONFIG_NGINX_GZIP_STATIC),y)
    ADDITIONAL_MODULES += --with-http_gzip_static_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_REAL_IP),y)
    ADDITIONAL_MODULES += --with-http_realip_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_SECURE_LINK),y)
    ADDITIONAL_MODULES += --with-http_secure_link_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_SUB),y)
	ADDITIONAL_MODULES += --with-http_sub_module
  endif
  ifeq ($(CONFIG_NGINX_STREAM_CORE_MODULE),y)
    ADDITIONAL_MODULES += --with-stream
  endif
  ifeq ($(CONFIG_NGINX_STREAM_SSL_MODULE),y)
    ADDITIONAL_MODULES += --with-stream_ssl_module
  endif
  ifeq ($(CONFIG_NGINX_STREAM_SSL_PREREAD_MODULE),y)
    ADDITIONAL_MODULES += --with-stream_ssl_preread_module
  endif
  ifeq ($(CONFIG_NGINX_HTTP_SUBSTITUTIONS_FILTER),y)
    ADDITIONAL_MODULES += --add-module=nginx-substitutions-filter
  endif
  ifeq ($(CONFIG_NGINX_HEADERS_MORE),y)
    ADDITIONAL_MODULES += --add-module=nginx-headers-more
  endif
  ifeq ($(CONFIG_NGINX_HTTP_BROTLI),y)
    ADDITIONAL_MODULES += --add-module=nginx-brotli
  endif
  ifeq ($(CONFIG_NGINX_RTMP_MODULE),y)
    ADDITIONAL_MODULES += --add-module=nginx-rtmp
  endif
  ifeq ($(CONFIG_NGINX_TS_MODULE),y)
    ADDITIONAL_MODULES += --add-module=nginx-ts
  endif
else
  CONFIG_NGINX_HEADERS_MORE:=y
  CONFIG_NGINX_HTTP_BROTLI:=y
  CONFIG_NGINX_HTTP_SUBSTITUTIONS_FILTER:=y
  CONFIG_NGINX_HTTP_UPSTREAM_CHECK:=y
  CONFIG_NGINX_RTMP_MODULE:=y
  CONFIG_NGINX_TS_MODULE:=y
  CONFIG_NGINX_NAXSI:=y
  CONFIG_NGINX_LUA:=y
  CONFIG_NGINX_DAV:=y
  CONFIG_NGINX_UBUS:=y
  ADDITIONAL_MODULES += --with-http_ssl_module --add-module=nginx-naxsi/naxsi_src \
    --add-module=lua-nginx --with-ipv6 --with-http_stub_status_module --with-http_flv_module \
	--with-http_dav_module --add-module=nginx-dav-ext-module \
	--with-http_auth_request_module --with-http_v2_module --with-http_realip_module \
	--with-http_secure_link_module --with-http_sub_module --add-module=nginx-headers-more \
	--with-stream --with-stream_ssl_module --with-stream_ssl_preread_module \
	--add-module=nginx-brotli --add-module=nginx-rtmp \
	--add-module=nginx-substitutions-filter \
	--add-module=nginx-upstream-check \
	--with-http_xslt_module \
	--add-module=nginx-ts --add-module=nginx-ubus-module
  config_files += koi-utf koi-win win-utf fastcgi_params 
  TARGET_CPPFLAGS += -I$(STAGING_DIR)/usr/include/libxml2
endif

define Package/nginx-mod-luci/default
  TITLE:=Nginx on LuCI
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Support file for Nginx
  URL:=http://nginx.org/
  DEPENDS:=+uwsgi +uwsgi-luci-support
endef

define Package/nginx-mod-luci
  $(Package/nginx-mod-luci/default)
  DEPENDS += +nginx
endef

define Package/nginx-mod-luci/description
 Support file for LuCI in nginx. Include custom nginx configuration, autostart script for uwsgi.
endef

define Package/nginx-mod-luci-ssl
  $(Package/nginx-mod-luci/default)
  TITLE += with HTTPS support
  DEPENDS += +nginx-ssl
endef

Package/nginx-mod-luci-ssl/description = $(define Package/nginx-mod-luci/description) \
  This also include redirect from http to https and cert autogeneration.

TARGET_CFLAGS += -fvisibility=hidden -ffunction-sections -fdata-sections -DNGX_LUA_NO_BY_LUA_BLOCK
TARGET_LDFLAGS += -Wl,--gc-sections

ifeq ($(CONFIG_NGINX_LUA),y)
  CONFIGURE_VARS += LUA_INC=$(STAGING_DIR)/usr/include \
					LUA_LIB=$(STAGING_DIR)/usr/lib
endif

CONFIGURE_ARGS += \
			--crossbuild=Linux::$(ARCH) \
			--prefix=/usr \
			--conf-path=/etc/nginx/nginx.conf \
			$(ADDITIONAL_MODULES) \
			--error-log-path=/var/log/nginx/error.log \
			--pid-path=/var/run/nginx.pid \
			--lock-path=/var/lock/nginx.lock \
			--http-log-path=/var/log/nginx/access.log \
			--http-client-body-temp-path=/var/lib/nginx/body \
			--http-proxy-temp-path=/var/lib/nginx/proxy \
			--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
			--with-cc="$(TARGET_CC)" \
			--with-cc-opt="$(TARGET_CPPFLAGS) $(TARGET_CFLAGS)" \
			--with-ld-opt="$(TARGET_LDFLAGS)" \
			--without-http_upstream_zone_module

define Package/nginx-mod-luci/install
	$(INSTALL_DIR) $(1)/etc/nginx
	$(INSTALL_BIN) ./files-luci-support/luci_uwsgi.conf $(1)/etc/nginx/luci_uwsgi.conf
	$(INSTALL_BIN) ./files-luci-support/luci_nginx.conf $(1)/etc/nginx/luci_nginx.conf
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files-luci-support/60_nginx-luci-support $(1)/etc/uci-defaults/60_nginx-luci-support
endef

define Package/nginx-mod-luci-ssl/install
	$(Package/nginx-mod-luci/install)
	$(INSTALL_DIR) $(1)/etc/nginx
	$(INSTALL_BIN) ./files-luci-support/luci_nginx_ssl.conf $(1)/etc/nginx/luci_nginx_ssl.conf
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files-luci-support/70_nginx-luci-support-ssl $(1)/etc/uci-defaults/70_nginx-luci-support-ssl
endef

define Package/nginx/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/nginx $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/nginx
	$(INSTALL_DATA) $(addprefix $(PKG_INSTALL_DIR)/etc/nginx/,$(config_files)) $(1)/etc/nginx/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/nginx.init $(1)/etc/init.d/nginx
ifeq ($(CONFIG_NGINX_NAXSI),y)
	$(INSTALL_DIR) $(1)/etc/nginx
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nginx-naxsi/naxsi_config/naxsi_core.rules $(1)/etc/nginx
	chmod 0640 $(1)/etc/nginx/naxsi_core.rules
endif
	$(if $(CONFIG_NGINX_NAXSI),$($(INSTALL_BIN) $(PKG_BUILD_DIR)/nginx-naxsi/naxsi_config/naxsi_core.rules $(1)/etc/nginx))
	$(if $(CONFIG_NGINX_NAXSI),$(chmod 0640 $(1)/etc/nginx/naxsi_core.rules))
endef

Package/nginx-ssl/install = $(Package/nginx/install)
Package/nginx-all-module/install = $(Package/nginx/install)

define Build/Prepare
	$(Build/Prepare/Default)
	$(Prepare/nginx-naxsi)
	$(Prepare/lua-nginx)
	$(Prepare/nginx-brotli)
	$(Prepare/nginx-headers-more)
	$(Prepare/nginx-rtmp)
	$(Prepare/nginx-ts)
	$(Prepare/nginx-dav-ext-module)
	$(Prepare/nginx-ubus-module)
	$(Prepare/nginx-substitutions-filter)
	$(Prepare/nginx-upstream-check)
endef


ifeq ($(CONFIG_NGINX_HEADERS_MORE),y)
  define Download/nginx-headers-more
    VERSION:=743a4bb1a253325d17a4f4ce8ee61ea0d8e0cc19
    SUBDIR:=nginx-headers-more
    FILE:=headers-more-nginx-module-$$(VERSION).tar.xz
    URL:=https://github.com/openresty/headers-more-nginx-module.git
    MIRROR_HASH:=db982641e3cf3e14ca250ef700085a745ed52ba6bb6dc51814af264bab1bac5a
    PROTO:=git
  endef
  $(eval $(call Download,nginx-headers-more))

  define Prepare/nginx-headers-more
	$(eval $(Download/nginx-headers-more))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_HTTP_BROTLI),y)
  define Download/nginx-brotli
    VERSION:=e505dce68acc190cc5a1e780a3b0275e39f160ca
    SUBDIR:=nginx-brotli
    FILE:=ngx-brotli-module-$$(VERSION).tar.xz
    URL:=https://github.com/google/ngx_brotli.git
    MIRROR_HASH:=04847f11ef808fed50f44b2af0ef3abf59ff0ffc06dfc7394d9ab51d53fef31f
    PROTO:=git
  endef
  $(eval $(call Download,nginx-brotli))

  define Prepare/nginx-brotli
	$(eval $(Download/nginx-brotli))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_HTTP_UPSTREAM_CHECK),y)
  define Download/nginx-upstream-check
    VERSION:=e538034b6ad7992080d2403d6d3da56e4f7ac01e
    SUBDIR:=nginx-upstream-check
    FILE:=nginx-upstream-check-module-$$(VERSION).tar.xz
    URL:=https://github.com/yaoweibin/nginx_upstream_check_module.git
    MIRROR_HASH:=973c8eb5d89e65c828e4e240b0643ed113b492ae1bb7c062911bcc69132ee762
    PROTO:=git
  endef
  $(eval $(call Download,nginx-upstream-check))

  define Prepare/nginx-upstream-check
	$(eval $(Download/nginx-upstream-check))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
	patch -p1 -d $(PKG_BUILD_DIR) < $(PKG_BUILD_DIR)/nginx-upstream-check/check_1.16.1+.patch
  endef
endif


ifeq ($(CONFIG_NGINX_HTTP_SUBSTITUTIONS_FILTER),y)
  define Download/nginx-substitutions-filter
    VERSION:=b8a71eacc7f986ba091282ab8b1bbbc6ae1807e0
    SUBDIR:=nginx-substitutions-filter
    FILE:=nginx-substitutions-filter-module-$$(VERSION).tar.xz
    URL:=https://github.com/yaoweibin/ngx_http_substitutions_filter_module.git
    MIRROR_HASH:=7ad03bf57f8aa7eeffb8ad687ddbf178f84e245308750ed66721bcff48261e44
    PROTO:=git
  endef
  $(eval $(call Download,nginx-substitutions-filter))

  define Prepare/nginx-substitutions-filter
	$(eval $(Download/nginx-substitutions-filter))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_RTMP_MODULE),y)
  define Download/nginx-rtmp
    VERSION:=3bf75232676da7eeff85dcd0fc831533a5eafe6b
    SUBDIR:=nginx-rtmp
    FILE:=ngx-rtmp-module-$$(VERSION).tar.xz
    URL:=https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
    MIRROR_HASH:=b28d747a6fe799e57eb27815704abf5b41334e55ab08cc4283e04bdb354017da
    PROTO:=git
  endef
  $(eval $(call Download,nginx-rtmp))

  define  Prepare/nginx-rtmp
	$(eval $(Download/nginx-rtmp))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_TS_MODULE),y)
  define Download/nginx-ts
    VERSION:=ef2f874d95cc75747eb625a292524a702aefb0fd
    SUBDIR:=nginx-ts
    FILE:=ngx-ts-module-$$(VERSION).tar.xz
    URL:=https://github.com/arut/nginx-ts-module.git
    MIRROR_HASH:=73938950bb286d40d9e54b0994d1a63827340c1156c72eb04d7041b25b20ec18
    PROTO:=git
  endef
  $(eval $(call Download,nginx-ts))

  define  Prepare/nginx-ts
	$(eval $(Download/nginx-ts))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_NAXSI),y)
  define Download/nginx-naxsi
    VERSION:=15e58c3385e339509bf5ea42437d195fa6e0e488
    SUBDIR:=nginx-naxsi
    FILE:=nginx-naxsi-module-$$(VERSION).tar.xz
    URL:=https://github.com/nbs-system/naxsi.git
    MIRROR_HASH:=3116afc224ce0335f4b1a5c7f16ecf4b03aa9a6e5ec2fb37d78d2cf3002844bc
    PROTO:=git
  endef
  $(eval $(call Download,nginx-naxsi))

  define Prepare/nginx-naxsi
	$(eval $(Download/nginx-naxsi))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif


ifeq ($(CONFIG_NGINX_LUA),y)
  define Download/lua-nginx
    VERSION:=e94f2e5d64daa45ff396e262d8dab8e56f5f10e0
    SUBDIR:=lua-nginx
    FILE:=lua-nginx-module-$$(VERSION).tar.xz
    URL:=https://github.com/openresty/lua-nginx-module.git
    MIRROR_HASH:=27729921964f066d97e99c263da153b34622a2f4b811114e4c3ee61c6fc71395
    PROTO:=git
  endef
  $(eval $(call Download,lua-nginx))

  define Prepare/lua-nginx
	$(eval $(Download/lua-nginx))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
	$(call PatchDir,$(PKG_BUILD_DIR),./patches-lua-nginx)
  endef
endif


ifeq ($(CONFIG_NGINX_DAV),y)
  define Download/nginx-dav-ext-module
    VERSION:=f5e30888a256136d9c550bf1ada77d6ea78a48af
    SUBDIR:=nginx-dav-ext-module
    FILE:=nginx-dav-ext-module-$$(VERSION).tar.xz
    URL:=https://github.com/arut/nginx-dav-ext-module.git
    MIRROR_HASH:=70bb4c3907f4b783605500ba494e907aede11f8505702e370012abb3c177dc5b
    PROTO:=git
  endef
  $(eval $(call Download,nginx-dav-ext-module))

  define Prepare/nginx-dav-ext-module
	$(eval $(Download/nginx-dav-ext-module))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
	$(call PatchDir,$(PKG_BUILD_DIR),./patches-dav-nginx)
  endef
endif

ifeq ($(CONFIG_NGINX_UBUS),y)
  define Download/nginx-ubus-module
    VERSION:=f30b0167a2cdb40f23bd90928d601bdb0c1b8fad
    SUBDIR:=nginx-ubus-module
    FILE:=nginx-ubus-module-$$(VERSION).tar.xz
    URL:=https://github.com/Ansuel/nginx-ubus-module.git
    MIRROR_HASH:=02c7d4b0df7f4b69605e71b0fefdc99b5a9470c68cad7ccfb31ebefe4e7e0704
    PROTO:=git
  endef
  $(eval $(call Download,nginx-ubus-module))

  define Prepare/nginx-ubus-module
	$(eval $(Download/nginx-ubus-module))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
  endef
endif

$(eval $(call BuildPackage,nginx))
$(eval $(call BuildPackage,nginx-ssl))
$(eval $(call BuildPackage,nginx-all-module))
$(eval $(call BuildPackage,nginx-mod-luci))
$(eval $(call BuildPackage,nginx-mod-luci-ssl))
