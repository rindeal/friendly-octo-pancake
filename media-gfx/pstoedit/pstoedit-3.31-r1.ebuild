# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Chouser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.31-r1.ebuild,v 1.1 2002/04/13 00:20:40 seemant Exp $

# nonstandard archive name and source dir
A=${P//[-.]/_}.zip
S=${WORKDIR}/${P/-/_}

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="http://home.t-online.de/home/helga.glunz/wglunz/${PN}/${A}"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

DEPEND="media-libs/libpng
	sys-libs/zlib"

RDEPEND="$DEPEND
	app-text/ghostscript"

src_compile() {
	cd ${S}/config
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	cd ${S}/src
	emake || die "emake failed"
}

src_install () {
	dodoc readme.txt copying changelog.htm
	cd ${S}/src
	make DESTDIR=${D} install || die "make install failed"
}
