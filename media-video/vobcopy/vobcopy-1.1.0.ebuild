# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vobcopy/vobcopy-1.1.0.ebuild,v 1.5 2008/02/16 18:44:08 dertobi123 Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="copies DVD .vob files to harddisk, decrypting them on the way"
HOMEPAGE="http://lpn.rnbhq.org/"
SRC_URI="http://lpn.rnbhq.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"

DEPEND=">=media-libs/libdvdread-0.9.4"

src_compile() {
	tc-export CC
	./configure.sh --with-lfs
	emake || die "emake failed"
}

src_install() {
	dobin vobcopy || die "dobin failed"
	doman vobcopy.1 || die "doman failed"
	dodoc Changelog README Release-Notes TODO alternative_programs.txt \
		|| die "dodoc failed"
}
