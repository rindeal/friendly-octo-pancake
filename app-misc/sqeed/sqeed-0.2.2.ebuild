# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sqeed/sqeed-0.2.2.ebuild,v 1.7 2003/02/13 09:09:35 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A simple bash script holding a database with notes."
SRC_URI="http://areanaos.cjb.net/${P}.tar.gz"
HOMEPAGE="http://areanaos.cjb.net/scode.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-apps/bash"

src_install() {
	insinto /etc/
	doins ${FILESDIR}/sqeed.data
	fperms 666 /etc/sqeed.data
	fperms 755 ./sqeed
	dobin sqeed

	dodoc install license
}
