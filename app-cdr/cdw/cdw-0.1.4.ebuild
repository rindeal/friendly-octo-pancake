# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdw/cdw-0.1.4.ebuild,v 1.5 2005/01/01 12:11:36 eradicator Exp $

DESCRIPTION="ncurses-based console frontend to cdrecord and mkisofs"
HOMEPAGE="http://cdw.sourceforge.net"
SRC_URI="mirror://sourceforge/cdw/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls"

RDEPEND="virtual/cdrtools"
DEPEND="sys-libs/ncurses
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/SUBDIRS/ s/doc//' ${S}/Makefile.in || \
			die "sed Makefile.in failed"
}

src_compile() {
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS THANKS \
		doc/{KNOWN_BUGS,README,default.conf} || die "dodoc failed"
}
