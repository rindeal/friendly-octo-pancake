# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cheesetracker/cheesetracker-0.9.1.ebuild,v 1.7 2004/06/24 23:54:54 agriffis Exp $

DESCRIPTION="A clone of Impulse Tracker with some extensions and a built-in sample editor; uses QT"
HOMEPAGE="http://cheesetronic.sf.net/"
SRC_URI="mirror://sourceforge/cheesetronic/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE="jack"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	=dev-libs/libsigc++-1.2*
	>=x11-libs/qt-3.0"

DEPEND="${RDEPEND}
	>=dev-util/scons-0.94-r2"

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin
	make INSTALL_DIR=${D}/usr/bin/ install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/*.txt
}
