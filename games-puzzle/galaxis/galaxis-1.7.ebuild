# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/galaxis/galaxis-1.7.ebuild,v 1.12 2010/10/18 17:14:37 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="A UNIX-hosted, curses-based clone of the nifty little Macintosh freeware game Galaxis"
HOMEPAGE="http://www.catb.org/~esr/galaxis/"
SRC_URI="http://www.catb.org/~esr/galaxis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.3"

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_install() {
	dogamesbin galaxis || die "dogamesbin failed"
	doman galaxis.6
	dodoc README
	prepgamesdirs
}
