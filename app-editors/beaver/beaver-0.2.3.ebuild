# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/beaver/beaver-0.2.3.ebuild,v 1.7 2003/02/13 06:38:32 vapier Exp $

P=beaver-0.2.3
S=${WORKDIR}/${P}

LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"

DESCRIPTION="An Early AdVanced EditoR"

SRC_URI="http://eturquin.free.fr/beaver/dloads/${P}.tar.gz"

HOMEPAGE="http://eturquin.free.fr/beaver/index.htm"

DEPEND=">=x11-libs/gtk+-1.2.10-r8"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}/src

	cp Makefile Makefile.orig
	sed -e "s:DESTDIR = /usr/local:DESTDIR = /usr:" \
	-e "s:OPTI    = -O3 -funroll-loops -fomit-frame-pointer #-mpentium:OPTI    = ${CFLAGS} -funroll-loops -fomit-frame-pointer:" Makefile.orig > Makefile
}

src_compile() {
	cd ${S}/src
	emake || die
}

src_install() {
	cd src
	make DESTDIR=${D}/usr \
	 MANDIR=/share/man \
	install || die
}
