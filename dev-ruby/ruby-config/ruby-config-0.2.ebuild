# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-config/ruby-config-0.2.ebuild,v 1.5 2004/02/29 16:39:17 ciaranm Exp $

DESCRIPTION="Utility to switch the ruby interpreter beging used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha ~hppa ~amd64 ~ia64"

DEPEND="dev-lang/ruby"

src_install() {
	newsbin ${FILESDIR}/ruby-config.sh ruby-config
}
