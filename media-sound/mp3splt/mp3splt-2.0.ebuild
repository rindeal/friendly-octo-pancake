# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.0.ebuild,v 1.4 2004/06/25 00:13:00 agriffis Exp $

IUSE=""

DESCRIPTION="A command line utility to split mp3 and ogg files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64"

DEPEND="media-libs/libogg
	media-libs/libvorbis
	media-sound/madplay"

src_compile() {
	econf || die
	emake || die "build failed"
}

src_install() {
	einstall || die "install failed"
}
