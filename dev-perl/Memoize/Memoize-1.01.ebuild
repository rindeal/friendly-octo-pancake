# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Memoize/Memoize-1.01.ebuild,v 1.7 2004/07/14 18:57:20 agriffis Exp $

inherit perl-module

MY_P=Memoize-${PV}
DESCRIPTION="Generic Perl function result caching system"
HOMEPAGE="http://perl.plover.com/Memoize/"
SRC_URI="http://www.cpan.org/modules/by-module/Memoize/${MY_P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64"
IUSE=""

S=${WORKDIR}/${MY_P}
