# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Authore: Tom von Schwerdtner <tvon@etria.org>
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_XPath/PEAR-XML_XPath-1.2-r1.ebuild,v 1.7 2004/08/03 17:12:29 agriffis Exp $

inherit php-pear

DESCRIPTION="The PEAR::XML_XPath class provided an XPath/DOM XML manipulation, maneuvering and query interface"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc ia64"
IUSE=""

pkg_postinst () {
	einfo
	einfo "NOTE: This package requires the domxml extension."
	einfo "To enable domxml, add xml2 to your USE settings"
	einfo "and re-merge php."
	einfo
}
