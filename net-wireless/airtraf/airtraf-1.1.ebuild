# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airtraf/airtraf-1.1.ebuild,v 1.2 2005/01/12 09:58:25 dragonheart Exp $

inherit eutils  toolchain-funcs

DESCRIPTION="AirTraf 802.11b Wireless traffic sniffer"
HOMEPAGE="http://www.elixar.com/"
SRC_URI="http://www.elixar.com/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=net-libs/libpcap-0.7.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}.patch
}

src_compile() {
	cd ${S}/src

	# Do some sedding to make compile flags work

	mv Makefile.rules ${T}
	sed -e "s:gcc:$(tc-getCC):" \
		-e "s:CFLAGS   = -Wall -O2:CFLAGS   = ${CFLAGS} -Wall:" \
		-e "s:c++:$(tc-getCXX):" \
		-e "s:CXXFLAGS = -Wall -O2:CXXFLAGS = ${CXXFLAGS} -Wall:" \
		${T}/Makefile.rules > Makefile.rules
	make || die
}

src_install () {
	newdoc ${S}/docs/airtraf_doc.html airtraf_documentation.html

	dobin ${S}/src/airtraf || die
}
