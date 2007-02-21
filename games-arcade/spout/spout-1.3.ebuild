# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/spout/spout-1.3.ebuild,v 1.5 2007/02/21 17:00:10 mr_bones_ Exp $

inherit eutils games

MY_P="spout-unix-${PV}"
DESCRIPTION="Abstract Japanese caveflier / shooter"
HOMEPAGE="http://freshmeat.net/projects/spout/"
SRC_URI="http://rohanpm.net/files/old/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.6"

S=${WORKDIR}/${MY_P}

src_install() {
	dogamesbin spout || die "dogamesbin failed"
	doicon spout.png
	make_desktop_entry spout "Spout"
	dodoc README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To play in fullscreen mode, do 'spout f'."
	einfo "To play in a greater resolution, do 'spout x', where"
	einfo "x is an integer; the larger x is, the higher the resolution."
	echo
	einfo "To play:"
	einfo "Accelerate - spacebar, enter, z, x"
	einfo "Pause - escape"
	einfo "Exit - shift+escape"
	einfo "Rotate - left or right"
	echo
}
