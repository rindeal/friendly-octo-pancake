# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.3-r2.ebuild,v 1.9 2003/10/21 23:32:39 seemant Exp $

inherit eutils

MY_PV=${PV/./_}
DESCRIPTION="multi-purpose text editor for the X Window System"
HOMEPAGE="http://nedit.org/"
SRC_URI="mirror://nedit/v${MY_PV}/${P}-source.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="spell"

RDEPEND="spell? ( virtual/aspell-dict )"
DEPEND="${RDEPEND}
	dev-util/yacc
	virtual/motif"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.diff

	cp ${S}/makefiles/Makefile.linux ${T}
	sed "s:-O:${CFLAGS} -D__LINUX__:" \
		${T}/Makefile.linux > ${S}/makefiles/Makefile.linux
}

src_compile() {
	make CC=${CC} linux || die
}

src_install() {
	into /usr
	dobin source/nedit
	exeinto /usr/bin
	newexe source/nc neditc
	newman doc/nedit.man nedit.1
	newman doc/nc.man neditc.1

	dodoc README ReleaseNotes ChangeLog COPYRIGHT
	cd doc
	dodoc *.txt nedit.doc README.FAQ NEdit.ad
	dohtml *.{dtd,xsl,xml,html,awk}
}
