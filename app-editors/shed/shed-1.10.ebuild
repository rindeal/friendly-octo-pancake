# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/shed/shed-1.10.ebuild,v 1.5 2005/01/01 13:34:15 eradicator Exp $

IUSE=""

DESCRIPTION="Simple Hex EDitor"
HOMEPAGE="http://shed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5.3"

src_compile() {

	econf || die "econf failed"
	emake AM_CXXFLAGS="${CXXFLAGS}" || die "emake failed"

}

src_install() {

	dodir /usr/bin /usr/share/man/man1
	make DESTDIR=${D} install || die "install failed"

	dodoc [A-Z][A-Z]* ChangeLog

}
