# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.11.ebuild,v 1.4 2004/05/26 19:59:40 kloeri Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"
SRC_URI="http://search.cpan.org/CPAN/authors/id/U/UM/UMEMOTO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/UMEMOTO/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc alpha"

DEPEND="${DEPEND}"
