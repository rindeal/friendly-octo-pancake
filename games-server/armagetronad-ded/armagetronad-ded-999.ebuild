# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/armagetronad-ded/armagetronad-ded-999.ebuild,v 1.1 2005/06/09 17:19:56 wolf31o2 Exp $


DESCRIPTION="3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetronad.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

pkg_postinst() {
	ewarn "This ebuild now installs nothing.  To get a dedicated armagetronad"
	ewarn "server, emerge games-action/armagetronad with USE=dedicated.  If you"
	ewarn "want only the server, then also use USE=-opengl."
}
