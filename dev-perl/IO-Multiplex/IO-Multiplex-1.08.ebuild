# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Multiplex/IO-Multiplex-1.08.ebuild,v 1.7 2005/07/07 19:04:14 corsair Exp $

inherit perl-module

DESCRIPTION="Manage IO on many file handles "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BB/BBB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
