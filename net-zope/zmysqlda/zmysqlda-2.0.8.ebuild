# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zmysqlda/zmysqlda-2.0.8.ebuild,v 1.2 2003/04/06 03:44:28 kutsuya Exp $

inherit zproduct
S="${WORKDIR}/lib/python/Products/"

DESCRIPTION="A MySQL Database Adapter(DA) for zope."
HOMEPAGE="http://sourceforge.net/projects/mysql-python"
SRC_URI="mirror://sourceforge/mysql-python/ZMySQLDA-${PV}.tar.gz"
LICENSE="GPL-2 | CNRI"
KEYWORDS="x86 ~ppc"
RDEPEND=">=dev-python/mysql-python-py21-0.9.2 
	${RDEPEND}"

ZPROD_LIST="ZMySQLDA"

