# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9express/snes9express-1.42.ebuild,v 1.4 2004/07/14 14:38:50 agriffis Exp $

DESCRIPTION="A graphical interface for the X11 versions of snes9x"
SRC_URI="mirror://sourceforge/snes9express/${P}.tar.gz"
HOMEPAGE="http://www.linuxgames.com/snes9express/"
LICENSE="GPL-2"
DEPEND=">=x11-libs/gtk+-2.0.0"
RDEPEND="games-emulation/snes9x"
IUSE=""
SLOT="0"
KEYWORDS="~ppc ~x86"

src_compile() {
	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install () {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README || \
		die "Installation of docs failed"
}
