# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@saintmail.net>

S=${WORKDIR}/${P}
DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/libl/liblockfile/liblockfile_1.03.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND=""

src_unpack() {
	unpack ${A}
	
	cd ${S}
}

src_compile() {
	cd ${S}

	./configure --with-mailgroup=mail --prefix=/usr --mandir=/usr/share/man
	make || die
}

src_install () {
	cd ${S}
	
	dodir /usr/bin /usr/include /usr/lib /usr/share/man/man1 /usr/share/man/man3
	make  ROOT=${D} install || die
}

