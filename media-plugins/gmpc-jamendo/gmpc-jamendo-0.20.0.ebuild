# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-jamendo/gmpc-jamendo-0.20.0.ebuild,v 1.5 2012/05/05 08:27:17 jdhore Exp $

EAPI=3

DESCRIPTION="Plugin allows you to browse and preview music available on jamendo."
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_JAMENDO"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=media-sound/gmpc-${PV}
	>=media-libs/libmpd-0.15.98
	dev-db/sqlite:3
	sys-libs/zlib
	>=dev-libs/libxml2-2.6
	>=x11-libs/gtk+-2.4:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/gob
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${ED}" -name "*.la" -delete || die
}
