# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.0.6.ebuild,v 1.5 2004/03/01 05:37:15 eradicator Exp $

DESCRIPTION="Music Score Typesetter"
HOMEPAGE="http://muse.seh.de/mscore/index.php"
LICENSE="GPL-2"

MY_P=mscore-${PV}
SRC_URI="http://muse.seh.de/mscore/bin//${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="x86"
IUSE="X"
S=${WORKDIR}/${MY_P}

DEPEND=">=x11-libs/qt-3.1.0"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	einstall
}

