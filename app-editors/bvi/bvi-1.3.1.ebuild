# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bvi/bvi-1.3.1.ebuild,v 1.11 2005/01/01 13:21:39 eradicator Exp $

DESCRIPTION="display-oriented editor for binary files, based on the vi texteditor"
HOMEPAGE="http://bvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/bvi/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~amd64 ppc"

DEPEND="sys-libs/ncurses"

src_compile() {
	econf --with-ncurses=/usr || die "econf failed"

	cp bmore.h bmore.h.old
	sed -e 's:ncurses/term.h:term.h:g' bmore.h.old > bmore.h

	emake || die "emake failed"
}

src_install() {
	einstall
	rm -rf ${D}/usr/share/bmore.help
	dodoc README CHANGES CREDITS bmore.help
	dohtml -r html/*
}
