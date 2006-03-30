# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SimpleUnit/Test-SimpleUnit-1.21.ebuild,v 1.7 2006/03/30 23:25:16 agriffis Exp $

inherit perl-module

DESCRIPTION="Simplified Perl unit-testing framework"
HOMEPAGE="http://search.cpan.org/~ged/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GE/GED/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/ExtUtils-AutoInstall
		dev-perl/Data-Compare"
