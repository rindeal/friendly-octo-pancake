# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.02-r1.ebuild,v 1.10 2005/04/28 17:20:30 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"
SRC_URI="mirror://cpan/authors/id/C/CN/CNANDOR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/C/CN/CNANDOR/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc ~ppc64 sparc alpha hppa ia64"
IUSE=""

DEPEND="|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
