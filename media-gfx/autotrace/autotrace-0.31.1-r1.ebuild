# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r1.ebuild,v 1.14 2005/02/18 17:34:39 agriffis Exp $

inherit eutils

IUSE="png flash imagemagick"

DESCRIPTION="Converts Bitmaps to vector-graphics"
SRC_URI="mirror://sourceforge/autotrace/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://autotrace.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha ppc amd64 ~sparc ia64"

DEPEND=">=x11-libs/gtkDPS-0.3.3
	media-libs/libexif
	>=x11-libs/gtk+-1.2.10-r4
	png? ( >=media-libs/libpng-1.2.5-r4 )
	flash? ( >=media-libs/ming-0.2a )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-imagemagick.patch
	autoconf
}

src_compile() {
	local myconf=""
	use imagemagick || myconf="--without-magick"
	econf ${myconf} --without-pstoedit || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
