# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3c/mp3c-0.29.ebuild,v 1.3 2004/06/25 00:12:10 agriffis Exp $

IUSE="oggvorbis"

DESCRIPTION="console based mp3 ripper, with cddb support"
HOMEPAGE="http://mp3c.wspse.de/WSPse/Linux-MP3c.php3?lang=en"
SRC_URI="ftp://excelsior.kullen.rwth-aachen.de/pub/linux/wspse/${P}.tar.gz"

DEPEND="media-sound/lame
	>=media-sound/mp3info-0.8.4-r1
	app-cdr/cdrtools
	oggvorbis? ( media-libs/libvorbis )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS *README BUGS CDDB_HOWTO COPYING ChangeLog FAQ NEWS OTHERS TODO
}
