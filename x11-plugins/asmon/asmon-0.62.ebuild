# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asmon/asmon-0.62.ebuild,v 1.8 2004/06/24 22:48:34 agriffis Exp $

inherit eutils

DESCRIPTION="WindowMaker/AfterStep system monitor dockapp"
HOMEPAGE="http://rio.vg/asmon/"
SRC_URI="http://www.tigr.net/afterstep/download/asmon/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 alpha ~sparc ppc"
DEPEND="virtual/x11"
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/asmon-cflags.diff
	epatch ${FILESDIR}/asmon-alpha.diff
}

src_compile() {
	cd ${S}/asmon
	make clean
	emake || die
}

src_install() {
	dodoc AUTHOR CHANGES Changelog INSTALL INSTALL.orig
	cd asmon
	dobin ${PN}
}
