# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-1.4.6.ebuild,v 1.4 2004/07/09 14:34:22 eldad Exp $

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://tcpreplay.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcpreplay/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" -j1 || die
}

src_install() {
	emake \
		prefix=${D}/usr \
		MAN8DIR=${D}/usr/share/man/man8 \
		MAN1DIR=${D}/usr/share/man/man1 \
		install \
		|| die "install failed"
	dodoc Docs/*
}
