# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r1.ebuild,v 1.5 2001/04/23 19:59:31 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND="virtual/glibc
        virtual/opengl 
        virtual/x11"

src_compile() {

	try ./configure --with-x --prefix=/usr --mandir=/usr/share/man
	try make
}

src_install () {

	try make prefix=${D}/usr mandir=${D}/usr/share/man install
    dodoc AUTHORS COPYING ChangeLog NEWS README
    docinto html
    dodoc public_html/*.{gif,jpg,html}
}


