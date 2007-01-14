# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-2.0.0-r1.ebuild,v 1.6 2007/01/14 19:04:42 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="Apache2 module enabling Netscape Communicator roaming profiles."
HOMEPAGE="http://www.klomp.org/mod_roaming/"
SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

APACHE2_MOD_CONF="18_mod_roaming"
APACHE2_MOD_DEFINE="ROAMING"

DOCFILES="CHANGES INSTALL LICENSE README"

need_apache2

pkg_postinst() {
	install -d -m 0755 -o apache -g apache "${ROOT}"/var/lib/${PN}
	apache2_pkg_postinst
}
