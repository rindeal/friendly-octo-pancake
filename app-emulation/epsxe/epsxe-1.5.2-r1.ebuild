# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/epsxe/epsxe-1.5.2-r1.ebuild,v 1.1 2003/08/17 19:47:34 vapier Exp $

inherit games

DESCRIPTION="ePSXe Playstation Emulator"
HOMEPAGE="http://www.epsxe.com/"
SRC_URI="http://download.epsxe.com/files/epsxe${PV//.}lin.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86"
IUSE="opengl"
RESTRICT="nostrip" # For some strange reason, strip truncates the whole file

DEPEND="app-arch/unzip"
RDEPEND=">=dev-libs/glib-1.2
	=x11-libs/gtk+-1.2*
	=sys-libs/ncurses-5*
	=sys-libs/zlib-1*
	net-misc/wget
	app-emulation/psemu-peopsspu
	|| (
		opengl? ( app-emulation/psemu-gpupetemesagl )
		app-emulation/psemu-peopssoftgpu
	)"

S=${WORKDIR}

src_install() {
	dogamesbin ${FILESDIR}/epsxe
	exeinto ${GAMES_PREFIX_OPT}/${PN}
	doexe epsxe
	insinto ${GAMES_PREFIX_OPT}/${PN}
	doins keycodes.lst

	insinto ${GAMES_LIBDIR}/psemu/cheats
	doins cheats/*

	dodoc docs/*

	prepgamesdirs
}
