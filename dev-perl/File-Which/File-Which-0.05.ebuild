# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Which/File-Which-0.05.ebuild,v 1.13 2009/09/17 17:48:12 tove Exp $

inherit perl-module

DESCRIPTION="Perl module implementing \`which' internally"
HOMEPAGE="http://search.cpan.org/search?module=File::Which"
SRC_URI="mirror://cpan/authors/id/P/PE/PEREINAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
mydoc="TODO"
