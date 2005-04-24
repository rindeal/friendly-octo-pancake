# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/data-buffer/data-buffer-0.04.ebuild,v 1.12 2005/04/24 13:17:59 hansmi Exp $

inherit perl-module

MY_P=Data-Buffer-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Read/write buffer class"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~mips ~ppc64"
IUSE=""
