# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.1.ebuild,v 1.7 2004/02/21 23:50:25 brad_mssw Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc amd64"

DEPEND="doc? ( app-text/docbook-sgml-utils
	>=app-text/docbook-sgml-dtd-4.1
	app-text/docbook-dsssl-stylesheets
	dev-perl/XML-RegExp )"


src_compile() {
	elibtoolize
	econf || die "./configure failed"
	make || die
}

src_install () {
	einstall || die
}
