# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/prokyon3/prokyon3-0.9.2.ebuild,v 1.11 2005/09/10 15:54:33 flameeyes Exp $

inherit eutils

DESCRIPTION="Multithreaded MP3 manager and tag editor based on Qt and MySQL"
HOMEPAGE="http://prokyon3.sourceforge.net"
SRC_URI="mirror://sourceforge/prokyon3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="ogg"

RESTRICT="primaryuri"

DEPEND="=x11-libs/qt-3*
	dev-db/mysql
	>=media-libs/id3lib-3.8.2
	ogg? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"

pkg_setup() {
	if has_version x11-libs/qt && ! built_with_use x11-libs/qt mysql ; then
		eerror "You have installed Qt without MySQL support."
		eerror "Please make sure "mysql" is in your USE variable"
		eerror "and reemerge Qt"
		die "MySQL support for Qt not found"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# do not assume that $x_libraries is not empty
	epatch "${FILESDIR}/${P}-configure.patch"
}

src_compile() {
	econf \
		$(use_with ogg) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install () {
	einstall || die "make install failed"
	dodoc ChangeLog NEWS README
}
