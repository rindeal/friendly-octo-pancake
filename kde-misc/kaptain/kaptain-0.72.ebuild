# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kaptain/kaptain-0.72.ebuild,v 1.3 2005/06/05 11:42:22 hansmi Exp $

inherit kde-functions eutils

DESCRIPTION="A universal graphical front-end for command line programs"
HOMEPAGE="http://kaptain.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaptain/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="ppc ~sparc x86"

need-qt 3

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
