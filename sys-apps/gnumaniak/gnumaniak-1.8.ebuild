# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnumaniak/gnumaniak-1.8.ebuild,v 1.12 2005/01/02 23:17:38 ciaranm Exp $

MY_PN=${PN/-/}
DESCRIPTION="Up to date man pages for various GNU utils section 1"
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"
HOMEPAGE="http://www.linalco.com/ragnar/"

SLOT="0"
LICENSE="LDP"
KEYWORDS="x86 amd64 ppc ~sparc alpha"
IUSE=""

RDEPEND="sys-apps/man"

src_install() {
	for x in `find * -type d -not -name ongoing`
	do
		doman $x/*.[1-9]
	done
	dodoc LICENSE README gnumaniak-1.8.lsm
}
