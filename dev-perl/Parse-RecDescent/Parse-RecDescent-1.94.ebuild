# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.94.ebuild,v 1.5 2003/09/06 22:37:58 msterret Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Parse/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Parse/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha hppa"

DEPEND="dev-perl/Text-Balanced"

src_install () {

	perl-module_src_install
	dohtml -r tutorial
}
