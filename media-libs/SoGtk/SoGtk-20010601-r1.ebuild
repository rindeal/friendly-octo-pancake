# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601-r1.ebuild,v 1.10 2002/11/09 07:56:01 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Gtk Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	<x11-libs/gtkglarea-1.99.0
	media-libs/coin"

src_compile() {

	./bootstrap --add

	econf || die
	make || die
}

src_install () {
	
	einstall || die
	
	cd ${S}
	dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
	docinto txt
	dodoc docs/*
}
