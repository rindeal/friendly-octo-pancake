# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-1.92.ebuild,v 1.1 2002/10/23 13:58:05 stubear Exp $

use perl && inherit perl-module

IUSE="perl"
DESCRIPTION="Network Kanji code conversion Filter"
SRC_URI="ftp://ftp.ie.u-ryukyu.ac.jp/pub/software/kono/${PN}${PV/./}.shar"
HOMEPAGE="http://bw-www.ie.u-ryukyu.ac.jp/~kono/software.html"
DEPEND=">=sys-apps/sharutils-4.2.1-r5"
KEYWORDS="~x86"
LICENSE="public-domain"
SLOT="0"
S=${WORKDIR}/${P}

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	mkdir NKF
	unshar -c ${DISTDIR}/${A}
	patch -s -p1 < ${FILESDIR}/${P}-msg00025.patch || die
}

src_compile() {
	make CC=gcc CFLAGS="${CFLAGS}" PERL=perl nkf test || die
	use perl && (
		cd ${S}/NKF
		perl-module_src_compile
		perl-module_src_test
	)
}

src_install() {
	exeinto /usr/bin
	doexe nkf
	doman nkf.1
	dodoc nkf.doc
	use perl && (
		cd ${S}/NKF
		perl-module_src_install
	)
}
