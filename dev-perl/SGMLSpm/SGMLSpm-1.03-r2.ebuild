# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03-r2.ebuild,v 1.2 2002/08/16 02:49:00 murphy Exp $

MY_P="${P}ii"
S=${WORKDIR}/${PN}
DESCRIPTION="Perl library for parsing the output of nsgmls"
SRC_URI="http://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${MY_P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {

	unpack ${A}
	cp ${FILESDIR}/${P}-Makefile ${S}/Makefile

}

src_install () {
	
	eval `perl '-V:package'`
	eval `perl '-V:version'`
	cd ${S}
	dodir /usr/lib/${package}/site_perl/${version}
	dodir /usr/bin
	make ${S}/Makefile  || die
	cd ${D}/usr/lib/${package}
	mv SGMLS.pm site_perl/${version}/SGMLS.pm

	dodoc BUGS COPYING ChangeLog README TODO

}
