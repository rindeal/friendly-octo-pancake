# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/parsedxml/parsedxml-1.3.1.ebuild,v 1.1 2003/03/25 11:51:26 kutsuya Exp $

inherit zproduct

DESCRIPTION="XML objects for Zope."
HOMEPAGE="http://www.zope.org/Members/faassen/ParsedXML"
SRC_URI="${HOMEPAGE}/ParsedXML-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="~x86"
RDEPEND=">=dev-python/PyXML-py21-0.8.1
	${RDEPEND}"

ZPROD_LIST="ParsedXML"


