# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/ck4up/ck4up-1.0.ebuild,v 1.1 2008/05/31 19:16:37 bangert Exp $

DESCRIPTION="Check for Updates on HTTP pages"
HOMEPAGE="http://jue.li/crux/ck4up/"
SRC_URI="http://jue.li/crux/ck4up/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby"

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc ChangeLog || die
}
