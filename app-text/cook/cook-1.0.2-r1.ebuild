# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cook/cook-1.0.2-r1.ebuild,v 1.1 2004/05/29 01:18:19 karltk Exp $

DESCRIPTION="COOK is an embedded language which can be used as a macro preprocessor and for similar text processing."
HOMEPAGE="http://cook.sourceforge.net/"
SRC_URI="mirror://sourceforge/cook/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="sys-libs/glibc"

src_compile() {
	cd ${S}
	emake
}

src_install() {
	cd ${S}
	dodoc README doc/cook.txt doc/cook.html
	dodir /usr/share/doc/${P}/example
	cd ${S}/test
	insinto /usr/share/doc/${P}/example
	doins pcb.dbdef pcb.dg pcbprol.ps tempsens.pcb
	cd ${S}
	newbin src/cook cookproc

	(
		echo "NOTICE:"
		echo
		echo " /usr/bin/cook has been renamed to /usr/bin/cookproc in Gentoo"
		echo
		echo " -- Karl Trygve Kalleberg <karltk@gentoo.org>"
	) > ${D}/usr/share/doc/${P}/README.Gentoo
}

pkg_postint() {
	ewarn "/usr/bin/cook has been renamed to /usr/bin/cookproc"
}