# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.20.0.ebuild,v 1.4 2004/06/25 00:17:41 agriffis Exp $

inherit kde-functions

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://savannah.nongnu.org/download/protux/${P}.tar.gz"

IUSE="static"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	=media-libs/libmustux-0.20*"

set-qtdir 3

src_compile() {
	export QT_MOC=${QTDIR}/bin/moc
	local myconf
	myconf="--with-gnu-ld"
	use static || myconf="${myconf} --enable-static=no"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}
