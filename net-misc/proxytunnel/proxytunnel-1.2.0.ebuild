# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxytunnel/proxytunnel-1.2.0.ebuild,v 1.1 2004/10/01 12:32:03 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="program that connects stdin and stdout to a server somewhere on the network, through a standard HTTPS proxy"
HOMEPAGE="http://proxytunnel.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxytunnel/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="static"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	use static && append-ldflags -static
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc CHANGES CREDITS README
}
