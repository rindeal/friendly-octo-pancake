# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Spec/File-Spec-3.31.ebuild,v 1.1 2009/11/10 10:31:11 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=SMUELLER
MY_PN=PathTools
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Handling files and directories portably"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build"

SRC_TEST="do"
myconf='INSTALLDIRS=vendor'
