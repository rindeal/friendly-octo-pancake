# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.3.01.ebuild,v 1.1 2004/04/25 14:12:05 spock Exp $

inherit eutils

MY_P=xfractint-20.03p01

S="${WORKDIR}/${MY_P}"
DESCRIPTION="The best fractal generator for X."
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/${MY_P}.tar.bz2"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="freedist"
IUSE=""

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	virtual/x11"

RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${MY_P}-make.patch
}

src_compile() {
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS = :CFLAGS = $CFLAGS :" Makefile.orig >Makefile

	MAKEOPTS='-j1' emake
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/xfractint
	dodir /usr/man/man1

	make \
		BINDIR=${D}usr/bin \
		MANDIR=${D}usr/man/man1 \
		SRCDIR=${D}usr/share/xfractint \
		install || die

	insinto /etc/env.d
	newins ${FILESDIR}/xfractint.envd 60xfractint
}

pkg_postinst() {
	einfo
	einfo "XFractInt requires the FRACTDIR variable to be set in order to start."
	einfo "Please re-login or \`source /etc/profile\` to have this variable set automatically."
	einfo
}
