# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegromp3/allegromp3-2.0.2.ebuild,v 1.5 2004/02/23 23:38:04 eradicator Exp $

DESCRIPTION="Allegro wrapper for the mpglib MP3 decoder part of mpg123"
HOMEPAGE="http://nekros.freeshell.org/delirium/almp3.php"
SRC_URI="http://raythe.sytes.net/TheDeath/almp3.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/allegro-4.0.0
	virtual/mpg123
	app-arch/unzip"

S=${WORKDIR}

src_compile() {
	sh fixunix.sh
	mv Makefile Makefile_orig
	sed s/'^TARGET=DJGPP_STATIC'/'#TARGET=DJGPP_STATIC'/ Makefile_orig| sed s/'#TARGET=LINUX_STATIC'/'TARGET=LINUX_STATIC'/ > Makefile
	emake || die
}

src_install() {
	dolib.a lib/linux/libalmp3.a

	insinto /usr/include
	doins include/*.h

	dodoc docs/*.txt *.txt
	docinto examples
	dodoc examples/{Makefile,example.c}
}
