# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-unix/ucspi-unix-0.34.ebuild,v 1.8 2003/02/13 16:19:12 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ucspi implementation for unix sockets."
SRC_URI="http://untroubled.org/ucspi-unix/${P}.tar.gz"

HOMEPAGE="http://untroubled.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
		doexe unixserver unixclient unixcat

	dodoc ANNOUNCEMENT ChangeLog NEWS PROTOCOL README TODO
}
