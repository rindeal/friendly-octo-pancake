# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-Pg/DBD-Pg-1.13-r1.ebuild,v 1.14 2006/08/05 02:09:09 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl DBD::Pg Module"
SRC_URI="mirror://cpan/authors/id/JBAKER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/JBAKER/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="dev-perl/DBI
	dev-db/postgresql
	dev-lang/perl"

RDEPEND="${DEPEND}"

# env variables for compilation:
export POSTGRES_INCLUDE=/usr/include/postgresql/
export POSTGRES_LIB=/usr/lib/postgresql/

mydoc="Changes README"
