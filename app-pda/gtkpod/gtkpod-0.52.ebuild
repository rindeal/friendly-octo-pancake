# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.52.ebuild,v 1.2 2003/09/29 15:11:08 tester Exp $

DESCRIPTION="GUI for iPod using GTK2"

HOMEPAGE="http://gtkpod.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.0
		>=x11-libs/pango-1.2.1
		media-libs/id3lib"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README
}
