# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jumpnbump/jumpnbump-1.41-r1.ebuild,v 1.5 2004/06/24 22:06:09 agriffis Exp $

inherit games

DESCRIPTION="a funny multiplayer game about cute little fluffy bunnies"
HOMEPAGE="http://www.jumpbump.mine.nu/"
SRC_URI="http://www.jumpbump.mine.nu/port/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="virtual/glibc
	virtual/x11
	>=media-libs/sdl-mixer-1.2
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-net-1.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' \
		-e 's:\$(PREFIX)/games/$:$(PREFIX)/games/bin/:g' Makefile || \
			die 'sed Makefile failed'

	sed -i \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' globals.pre || \
			die 'sed globals.pre failed'

	sed -i \
		-e 's:%%PREFIX%%/games/:%%PREFIX%%/share/games/:' \
		-e 's:/share/jumpnbump/:/share/games/jumpnbump/:' jnbmenu.pre || \
			die 'sed jnbmenu.pre failed'
}

src_compile() {
	emake PREFIX=/usr || die "emake failed"
}

src_install() {
	make PREFIX=${D}/usr install || die "make install failed"
	prepgamesdirs
}
