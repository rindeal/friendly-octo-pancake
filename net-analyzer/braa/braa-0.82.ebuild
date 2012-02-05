# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/braa/braa-0.82.ebuild,v 1.3 2012/02/05 18:31:17 armin76 Exp $

EAPI="3"

inherit toolchain-funcs eutils

DESCRIPTION="Quick and dirty mass SNMP scanner"
HOMEPAGE="http://s-tech.elsat.net.pl/braa/"
SRC_URI="http://s-tech.elsat.net.pl/braa/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8-gentoo.diff
	sed -i braa.c -e 's|0.81|0.82|g' || die
	tc-export CC
}

src_install() {
	dobin braa
	dodoc README
}
