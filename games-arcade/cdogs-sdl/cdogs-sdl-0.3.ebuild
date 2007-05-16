# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cdogs-sdl/cdogs-sdl-0.3.ebuild,v 1.1 2007/05/16 06:42:21 tupone Exp $

inherit eutils games

CDOGS_DATA="cdogs-data-2006-08-16"

DESCRIPTION="A port of the old DOS arcade game C-Dogs"
HOMEPAGE="http://lumaki.com/code/cdogs"
SRC_URI="http://icculus.org/${PN}/files/src/${P}.tar.bz2
	http://icculus.org/${PN}/files/data/${CDOGS_DATA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/sdl-mixer"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	mv ${CDOGS_DATA} ${P}/data || die "Failed moving data around"
	cd "${S}"
	sed -i -e "/^CF_OPT/d" \
		Makefile || die "Failed patching Makefile"
}

src_compile() {
	emake I_AM_CONFIGURED=yes \
		SYSTEM=\"linux\" \
		DATADIR=\"${GAMES_DATADIR}/${PN}\" \
		cdogs || die "emake failed"
}

src_install() {
	emake DESTDIR=\"${D}\" \
		BINDIR=\"${GAMES_BINDIR}\" \
		DATADIR=\"${GAMES_DATADIR}/${PN}\" \
		install || die "emake install failed"
	newicon ../data/cdogs_icon.png ${PN}.png
	make_desktop_entry "cdogs -fullscreen" ${PN} ${PN}.png

	cd ../doc
	dodoc README AUTHORS ChangeLog README_DATA TODO original_readme.txt

	prepgamesdirs
}
