# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-gfx/sdl-gfx-2.0.13.ebuild,v 1.3 2005/04/21 19:09:31 mr_bones_ Exp $

inherit flag-o-matic

MY_P="${P/sdl-/SDL_}"
DESCRIPTION="Graphics drawing primitives library for SDL"
HOMEPAGE="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/index.html"
SRC_URI="http://www.ferzkopp.net/~aschiffler/Software/SDL_gfx-2.0/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="mmx"

DEPEND=">=media-libs/libsdl-1.2"

S=${WORKDIR}/${MY_P}

src_compile() {
	filter-flags -finline-functions -funroll-loops #26892 #89749
	replace-flags -O? -O2

	econf $(use_enable mmx) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -r Docs/*
}
