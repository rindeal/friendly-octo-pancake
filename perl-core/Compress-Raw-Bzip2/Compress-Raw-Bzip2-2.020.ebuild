# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Bzip2/Compress-Raw-Bzip2-2.020.ebuild,v 1.7 2009/10/30 15:47:05 haubi Exp $

EAPI=2

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Low-Level Interface to bzip2 compression library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="test"

RDEPEND="app-arch/bzip2"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do

src_configure(){
	BUILD_BZIP2=0 BZIP2_INCLUDE=. BZIP2_LIB= \
		perl-module_src_configure
}
