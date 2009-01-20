# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.31.ebuild,v 1.1 2009/01/20 14:33:53 tove Exp $

MODULE_AUTHOR=RDF
inherit perl-module

DESCRIPTION="Recursively copy Perl datatypes"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
mymake='OPTIMIZE=${CFLAGS}'
DEPEND="dev-lang/perl"
