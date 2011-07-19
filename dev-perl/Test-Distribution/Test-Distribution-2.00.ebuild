# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Distribution/Test-Distribution-2.00.ebuild,v 1.4 2011/07/19 19:51:14 maekke Exp $

EAPI=2

MODULE_AUTHOR="SRSHAH"
inherit perl-module

DESCRIPTION="perform tests on all modules of a distribution"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-perl/Pod-Coverage-0.20
	>=dev-perl/File-Find-Rule-0.30
	dev-perl/Test-Pod-Coverage
	>=virtual/perl-Module-CoreList-2.17
	>=dev-perl/Test-Pod-1.26"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
