# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-1.10.2.ebuild,v 1.1 2004/01/16 02:10:39 mr_bones_ Exp $

inherit games

MY_P="${P}.20031223"
S="${WORKDIR}/${PN}-1.10.2.20031223"
DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/opengl"

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS README.UNIX TODO README ChangeLog BUGS PORTING || \
		die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "This version of ${PN} breaks compatibility with all previous releases"
	echo
}
