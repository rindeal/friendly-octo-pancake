# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdrawer/wmdrawer-0.10.2.ebuild,v 1.6 2004/06/24 23:08:59 agriffis Exp $

IUSE=""
DESCRIPTION="wmDrawer is a dock application (dockapp) which provides a drawer (retractable button bar) to launch applications"
SRC_URI="http://people.easter-eggs.org/~valos/wmdrawer/${P}.tar.gz"
HOMEPAGE="http://people.easter-eggs.org/~valos/wmdrawer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc"

DEPEND="virtual/x11
	media-libs/gdk-pixbuf"

src_compile() {
	emake || die "make failed!"
}

src_install() {
	dobin wmdrawer
	dodoc COPYING INSTALL README TODO AUTHORS ChangeLog wmdrawerrc.example
	gzip -cd doc/wmdrawer.1x.gz > wmdrawer.1
	doman wmdrawer.1
}
