# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mbr/mbr-1.1.5.ebuild,v 1.2 2002/12/09 04:17:35 manson Exp $

DESCRIPTION="A replacement master boot record for IBM-PC compatible computers"
HOMEPAGE="http://www.chiark.greenend.org.uk/~neilt/mbr/"
SRC_URI="http://www.chiark.greenend.org.uk/~neilt/mbr/${P}.tar.gz"
DEPEND="virtual/glibc"
KEYWORDS="~x86 -ppc -sparc  -alpha"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	into /
	dosbin install-mbr
	doman install-mbr.8
	dodoc AUTHORS ChangeLog COPYING INSTALL install-mbr.8 NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "To install the MBR, run /sbin/install-mbr"
	einfo
}
