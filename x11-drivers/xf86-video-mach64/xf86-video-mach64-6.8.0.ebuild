# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-mach64/xf86-video-mach64-6.8.0.ebuild,v 1.9 2009/06/23 20:03:09 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="ATI Mach64 video driver"

KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
LICENSE="xf86-video-ati"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2
	!<x11-drivers/xf86-video-ati-6.9"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86miscproto
	x11-proto/xproto
	dri? ( x11-proto/glproto
			x11-proto/xf86driproto
			>=x11-libs/libdrm-2 )"

PATCHES=""

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
