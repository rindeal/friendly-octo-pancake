# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/jrisk/jrisk-1.0.7.6.ebuild,v 1.1 2005/06/28 03:25:07 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="The well-known board game, written in java"
HOMEPAGE="http://jrisk.sourceforge.net"
SRC_URI="mirror://sourceforge/jrisk/Risk_src_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	>=dev-java/ant-core-1.4.1
	jikes? ( >=dev-java/jikes-1.17 )"

S=${WORKDIR}/Risk

src_compile() {
	local antflags="game"

	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
	# change the cd directory of the executable 
	# has to be done after the ant compilation
	sed \
		-e "/dirname/ s:.*:cd \"${GAMES_DATADIR}/${PN}\":" \
		"${S}"/build/game/FlashGUI.sh \
		> "${T}"/jrisk \
		|| die "sed failed"
}

src_install() {
	dogamesbin "${T}"/jrisk || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r build/game/* || die "doins failed"
	rm -f "${D}${GAMES_DATADIR}"/${PN}/*.cmd

	newicon build/game/resources/risk.png ${PN}.png
	make_desktop_entry ${PN} "Risk"

	prepgamesdirs
}
