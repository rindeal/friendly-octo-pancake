# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmdf/wmdf-0.1.6.ebuild,v 1.1 2003/12/16 04:52:46 port001 Exp $

IUSE=""

DESCRIPTION="An app to monitor disk space on partitions"
SRC_URI="http://dockapps.org/download.php/id/359/${P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/175"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README AUTHORS COPYING ChangeLog NEWS THANKS TODO INSTALL
}
