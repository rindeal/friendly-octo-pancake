# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-avahi/gmpc-avahi-0.20.0.ebuild,v 1.6 2012/05/05 08:27:17 jdhore Exp $

EAPI=3

DESCRIPTION="This plugin discovers avahi enabled mpd servers"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_AVAHI"
SRC_URI="http://download.sarine.nl/Programs/gmpc/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	net-dns/avahi[dbus]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking
}

src_install () {
	emake DESTDIR="${D}" install || die
	find "${ED}" -name "*.la" -delete || die
}
