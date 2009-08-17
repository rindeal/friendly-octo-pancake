# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/blokish/blokish-0.9.4-r1.ebuild,v 1.6 2009/08/17 21:36:00 mr_bones_ Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit eutils wxwidgets games

MY_P="${PN}_v${PV}"
DESCRIPTION="Open source clone of the four-player board game Blokus"
HOMEPAGE="http://sourceforge.net/projects/blokish/"
SRC_URI="mirror://sourceforge/blokish/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X,opengl]
	virtual/opengl"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "s:wx-config:${WX_CONFIG}:" \
		configure makefile.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/${PN}.xpm
	make_desktop_entry ${PN} Blokish ${PN}

	dodoc AUTHORS ChangeLog README
	dohtml docs/*
	prepgamesdirs
}
