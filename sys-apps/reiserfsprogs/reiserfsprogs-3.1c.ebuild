# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfsprogs/reiserfsprogs-3.1c.ebuild,v 1.1 2002/05/07 03:41:16 drobbins Exp $

MYPV=3.x.1c-pre3
S=${WORKDIR}/reiserfsprogs-${MYPV}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/pre/reiserfsprogs-${MYPV}.tar.gz"
HOMEPAGE="http://www.namesys.com"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	./configure --prefix=/ || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /usr/share
	cd ${D}
	mv man usr/share
	dosym /sbin/reiserfsck /sbin/fsck.reiserfs
	if [ "`use bootcd`" ]
	then
		rm -rf ${D}/usr
	fi
}

