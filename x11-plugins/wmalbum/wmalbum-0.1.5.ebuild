# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmalbum/wmalbum-0.1.5.ebuild,v 1.5 2004/06/24 23:04:18 agriffis Exp $

DESCRIPTION="WMAlbum is a dock applet that displays album covers for songs being played by XMMS."
HOMEPAGE="http://wmalbum.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmalbum/wmalbum-0.1.5.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""
RDEPEND="media-sound/xmms"
DEPEND="virtual/x11
	media-libs/gdk-pixbuf"

src_install() {
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO THANKS
	insinto /usr/share/doc/${PF}
	doins wmalbum
}
