# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/treecc/treecc-0.2.6.ebuild,v 1.11 2004/01/01 17:14:13 scandium Exp $

DESCRIPTION="compiler-compiler tool for aspect-oriented programming"
HOMEPAGE="http://www.southern-storm.com.au/treecc.html"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha amd64 ~ia64"

IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
