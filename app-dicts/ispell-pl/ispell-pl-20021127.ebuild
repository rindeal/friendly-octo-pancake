# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pl/ispell-pl-20021127.ebuild,v 1.3 2004/06/15 08:02:23 kloeri Exp $

DESCRIPTION="Polish dictionary for ispell"
SRC_URI="mirror://sourceforge/ispell-pl/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://ispell-pl.sourceforge.net/"

IUSE=""
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="app-text/ispell"

src_compile() {
	./zbuduj.slownik.sh
}

src_install () {
	insinto /usr/lib/ispell
	doins polish.aff polish.hash
	dodoc Changelog CZYTAJ.TO
}
