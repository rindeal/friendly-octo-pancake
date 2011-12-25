# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load/Class-Load-0.130.0.ebuild,v 1.1 2011/12/25 11:54:14 tove Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="A working (require q{Class::Name}) and more"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
	dev-perl/Data-OptList
	>=dev-perl/Module-Runtime-0.11.0
	>=dev-perl/Package-Stash-0.320.0
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Fatal
		dev-perl/Test-Requires
	)"

SRC_TEST="do"
