# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-gnutella/gift-gnutella-0.0.5.ebuild,v 1.1 2003/08/04 18:41:13 lostlogic Exp $

DESCRIPTION="The giFT Gnutella plugin"
HOMEPAGE="http://gift.sf.net/"
SRC_URI="mirror://sourceforge/gift/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="virtual/glibc
	>=net-p2p/gift-0.11.3
	>=sys-apps/sed-4
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${P}

src_compile() {
	econf || dir "failed to configure"
	emake || die "failed to build"
}

src_install() {
	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/lib/giFT \
		 datadir=${D}/usr/share/giFT \
		 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die "Install failed"
}

pkg_postinst() {
	einfo "To run giFT with Gnutella support, run:"
	einfo "giFT -p /usr/lib/giFT/libGnutella.so"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/gift.conf configuration file:"
	einfo "plugins = Gnutella"
}


