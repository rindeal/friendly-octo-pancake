# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.ebuild,v 1.6 2003/03/28 10:45:06 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="cksfv: SFV checksum utility (simple file verification)"
SRC_URI="http://www.fodder.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.fodder.org/cksfv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc sparc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dobin src/cksfv
	dodoc COPYING ChangeLog INSTALL README TODO
}
