# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-gpupetexgl2/psemu-gpupetexgl2-2.0.5-r2.ebuild,v 1.5 2004/11/03 00:18:40 vapier Exp $

inherit games

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://home.t-online.de/home/PeteBernert/"
SRC_URI="http://home.t-online.de/home/PeteBernert/gpupetexgl${PVR//.}.tar.gz
	http://home.t-online.de/home/PeteBernert/pete_ogl2_shader_simpleblur.zip
	http://home.t-online.de/home/PeteBernert/pete_ogl2_shader_scale2x.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe lib*
	exeinto "${GAMES_LIBDIR}/psemu/cfg"
	doexe cfgPeteXGL2
	insinto "${GAMES_LIBDIR}/psemu/cfg"
	doins gpuPeteXGL2.cfg
	# now do our shader files!
	insinto "${GAMES_LIBDIR}/psemu/shaders"
	doins *.fp *.vp *.slf *.slv
	dodoc *.txt
	prepgamesdirs
}
