# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-3.8.ebuild,v 1.5 2004/04/27 21:47:20 agriffis Exp $

DESCRIPTION="A tiny psuedoshell which only permits scp and sftp"
SRC_URI="http://www.sublimation.org/scponly/${P}.tgz"
HOMEPAGE="http://www.sublimation.org/scponly/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc
	net-misc/openssh"

S=${WORKDIR}/${P}

src_compile() {

	PATH="${PATH}:/usr/lib/misc" ./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		|| die "./configure failed"

	emake || die
}

src_install () {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		CONFDIR=${D}/etc/scponly \
		install || die
	grep -v scponly /etc/shells > ${D}/etc/shells
	echo "/usr/bin/scponly" >> ${D}/etc/shells

	dodoc AUTHOR CHANGELOG CONTRIB README TODO
}
