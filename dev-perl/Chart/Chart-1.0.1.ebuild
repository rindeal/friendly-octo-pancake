# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-1.0.1.ebuild,v 1.1 2002/05/05 14:08:57 seemant Exp $

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Chart Module"
SRC_URI="http://www.cpan.org/modules/by-module/Chart/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Chart/${MY_P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/GD-1.19"

mydoc="TODO"
