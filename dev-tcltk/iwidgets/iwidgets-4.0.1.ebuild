# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/iwidgets/iwidgets-4.0.1.ebuild,v 1.4 2004/03/25 06:30:25 weeve Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}

ITCL_MY_PN="itcl"
ITCL_MY_PV="3.2.1"
ITCL_MY_P="${ITCL_MY_PN}${ITCL_MY_PV}"

DESCRIPTION="Widget collection for incrTcl/incrTk"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}.tar.gz
		 mirror://sourceforge/incrtcl/${ITCL_MY_P}_src.tgz"
HOMEPAGE="http://www.tcltk.com/${PN}/"

SLOT="0"
LICENSE="as-is BSD"
KEYWORDS="x86 ~ppc sparc"
DEPEND=">=dev-tcltk/itcl-3.2.1"
PDEPEND="dev-tcltk/iwidgets"

src_compile() {
	local myconf
	myconf="${myconf} --with-itcl=${WORKDIR}/${ITCL_MY_P}"
	econf ${myconf} || die "configure failed"
	# we don't need to compile anything
}

src_install() {
	einstall || "einstall failed"
	dodoc CHANGES ChangeLog README license.terms
	doman doc/*.n
}
