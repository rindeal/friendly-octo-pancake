# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.2.3.ebuild,v 1.5 2004/06/24 22:12:07 agriffis Exp $

inherit eutils games

DESCRIPTION="A clone of the old dos Skyroads game"
HOMEPAGE="http://skystreets.kaosfusion.com/"
SRC_URI="http://skystreets.kaosfusion.com/${P}.tar.bz2"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~alpha"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/levels.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS CODE ChangeLog README TODO
	prepgamesdirs
}
