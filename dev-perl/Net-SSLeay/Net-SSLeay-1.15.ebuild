# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.15.ebuild,v 1.8 2002/10/04 05:22:09 vapier Exp $

inherit perl-module

MY_P=${PN/-/_}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Net::SSLeay module for perl"
SRC_URI="http://www.cpan.org/authors/id/SAMPO/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/SAMPO/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND} dev-libs/openssl"

export OPTIMIZE="$CFLAGS"
