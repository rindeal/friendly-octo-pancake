# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.4.ebuild,v 1.10 2004/03/12 08:22:51 mr_bones_ Exp $

DESCRIPTION="File searcher"
HOMEPAGE="http://glark.sf.net"
SRC_URI="mirror://sourceforge/glark/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND=">=dev-lang/ruby-1.6.7"

src_compile() {
	emake || die
}

src_install () {
	dobin glark
	doman glark.1
}
