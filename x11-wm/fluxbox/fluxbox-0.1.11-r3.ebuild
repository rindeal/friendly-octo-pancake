# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.11-r3.ebuild,v 1.5 2003/02/13 17:47:19 vapier Exp $

IUSE="nls"

inherit commonbox flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox and pwm -- has tabs."
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
	http://fluxbox.sourceforge.net/download/patches/${P}-bugfix2.patch"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

mydoc="ChangeLog COPYING NEWS"
myconf="--enable-xinerama"
filter-flags -fno-exceptions
export WANT_AUTOMAKE_1_6=1
export WANT_AUTOCONF_2_5=1

src_unpack() {

	unpack ${P}.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/${PN}-vano-gentoo.patch || die
	patch -p1 < ${DISTDIR}/${P}-bugfix2.patch || die
}

src_compile() {

	commonbox_src_compile

	cd data
	make \
		pkgdatadir=/usr/share/commonbox init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init
	insinto /usr/share/commonbox/fluxbox
	doins keys
}
