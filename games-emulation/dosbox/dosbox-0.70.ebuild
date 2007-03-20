# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.70.ebuild,v 1.4 2007/03/20 04:39:46 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="alsa debug hardened opengl sdl png"

DEPEND="alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	debug? ( sys-libs/ncurses )
	media-libs/libsdl
	sdl? ( media-libs/sdl-net
		media-libs/sdl-sound )"

pkg_setup() {
	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "To be able to build dosbox with ALSA support you need"
		eerror "to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
	games_pkg_setup
}

src_compile() {
	local myconf=

	if ! use alsa ; then
		myconf="--without-alsa-prefix --without-alsa-inc-prefix --disable-alsatest"
	fi
	# bug #66038
	if use hardened ; then
		myconf="${myconf} --disable-dynamic-x86"
	fi
	if use debug ; then
		myconf="${myconf} --enable-debug"
	fi
	egamesconf \
		--disable-dependency-tracking \
		${myconf} \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	prepgamesdirs
}
