# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdoc/kdoc-2.0_alpha54.ebuild,v 1.11 2003/11/16 18:40:20 brad_mssw Exp $

IUSE=""
MY_P=${P/_alph/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="KDE/QT documentation processing/generation tools"
HOMEPAGE="http://www.ph.unimelb.edu.au/~ssk/kde/kdoc/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc amd64"

DEPEND="dev-lang/perl"

src_compile() {
	export KDEDIR=""
	export QTDIR=""
	econf
	emake || die
}

src_install() {
	einstall
}
