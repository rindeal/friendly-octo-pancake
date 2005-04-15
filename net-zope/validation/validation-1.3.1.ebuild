# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/validation/validation-1.3.1.ebuild,v 1.1 2005/04/15 17:16:44 radek Exp $

inherit zproduct

DESCRIPTION="Data validation package, originally designed for Archetypes."
WEBPAGE="http://www.sourceforge.net/projects/archetypes"
SRC_URI="mirror://sourceforge/archetypes/${PF}-final.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
SLOT="1.3"

RDEPEND=">=net-zope/cmf-1.4.7"

ZPROD_LIST="validation"

src_install()
{
	zproduct_src_install all

}

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn "Please be warned that it should not be used together with dev-python/validation !"
}
