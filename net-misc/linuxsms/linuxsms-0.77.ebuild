# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linuxsms/linuxsms-0.77.ebuild,v 1.1 2004/05/06 06:25:17 dragonheart Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A console perl script for sending SMS to cell phones"
SRC_URI="mirror://sourceforge/linuxsms/${P}.tar.gz"
HOMEPAGE="http://linuxsms.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~sparc "
LICENSE="GPL-2"
SLOT="0"
RESTRICT="nomirror"

DEPEND=">=dev-lang/perl-5.6.1"

src_install () {
	dobin linuxsms

	doman linuxsms.1
	dodoc BUGS CHANGES COPYING INSTALL README README.ES TODO
}

pkg_postinst() {
	einfo "To run linuxsms, just type: linuxsms"
	einfo "Your config file will be located in ~/.linuxsms"
}
