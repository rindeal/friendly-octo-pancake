# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpasman/wmpasman-0.8.3.ebuild,v 1.4 2004/06/24 23:15:40 agriffis Exp $

IUSE=""

DESCRIPTION="Password storage/retrieval in a dockapp"
HOMEPAGE="http://sourceforge.net/projects/wmpasman/"
SRC_URI="mirror://sourceforge/wmpasman/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"

DEPEND=">=x11-libs/gtk+-2.0
	app-crypt/mhash
	app-crypt/mcrypt"

src_install() {
	einstall

	dodoc BUGS ChangeLog README TODO WARNINGS
}

pkg_postinst() {
	ewarn "Please read the WARNINGS file."
}

