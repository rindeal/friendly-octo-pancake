# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.5.ebuild,v 1.11 2004/07/01 22:26:55 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="mirror://sourceforge/rproxy/${P}.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/rproxy/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install  || die

	dodoc COPYING NEWS INSTALL AUTHORS THANKS README TODO
}
