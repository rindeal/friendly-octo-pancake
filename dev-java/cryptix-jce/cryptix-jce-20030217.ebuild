# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix-jce/cryptix-jce-20030217.ebuild,v 1.5 2004/07/14 01:50:24 agriffis Exp $

inherit java-pkg

DESCRIPTION="Cryptix JCE is a complete clean-room implementation of the official JCE 1.2 API as published by Sun."
SRC_URI="http://cryptix.org/dist/${P}-snap.zip"
HOMEPAGE="http://cryptix.org/products/jce/"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}

src_compile() {
	einfo "This ebuild is, for the time being, just a binary install."
}

src_install() {
	dodoc README.TXT ChangeLog.txt LICENCE.TXT
	java-pkg_dojar bin/*.jar
}
