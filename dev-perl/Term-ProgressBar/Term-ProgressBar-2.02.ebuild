# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.02.ebuild,v 1.4 2003/09/06 22:37:58 msterret Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl module for Term-ProgressBar"
SRC_URI="http://search.cpan.org/CPAN/authors/id/F/FL/FLUFFY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/FLUFFY/Term-ProgressBar-2.02/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="dev-perl/Class-MethodMaker
		dev-perl/TermReadKey"

