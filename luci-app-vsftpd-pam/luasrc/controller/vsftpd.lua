-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Copyright 2018 cmheia <cmheia@gmail.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.vsftpd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vsftpd") then
		return
	end

	local page

	page = entry({"admin", "services", "vsftpd"}, cbi("vsftpd"), _("vsftpd FTP Server"))
	page.dependent = true
end
