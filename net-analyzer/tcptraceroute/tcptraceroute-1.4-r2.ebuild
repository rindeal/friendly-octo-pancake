# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.4-r2.ebuild,v 1.1 2003/08/21 04:56:04 vapier Exp $

inherit eutils

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~arm"

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.0.2a-r3
	<net-libs/libnet-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_compile() {
	make CFLAGS="$CFLAGS" || die
}

src_install() {
	dobin tcptraceroute
	fperms u+s /usr/bin/tcptraceroute

	doman tcptraceroute.8
	dodoc examples.txt COPYING README changelog
	dohtml -r ./
}
