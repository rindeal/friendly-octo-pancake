# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-1.0.1.ebuild,v 1.4 2002/07/23 22:29:48 seemant Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Chart Module"
SRC_URI="http://www.cpan.org/modules/by-module/Chart/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Chart/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=dev-perl/GD-1.19"

mydoc="TODO"
