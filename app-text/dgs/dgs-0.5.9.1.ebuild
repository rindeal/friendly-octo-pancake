# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.9.1.ebuild,v 1.2 2000/10/09 16:02:49 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/dgs-0.5.9
DESCRIPTION="A Ghostscript based DPS server"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dgs/${A}"
HOMEPAGE="http://www.aist-nara.ac.jp/~masata-y/dgs/index.html"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-x
    try make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr install
    prepman
    dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}

