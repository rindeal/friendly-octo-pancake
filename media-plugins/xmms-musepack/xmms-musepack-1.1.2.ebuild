# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-1.1.2.ebuild,v 1.4 2005/05/28 19:53:32 luckyduck Exp $

DESCRIPTION="Musepack input plugin for XMMS"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/linux/plugins/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

DEPEND="media-sound/xmms
	>=media-libs/libmusepack-1.1"

src_compile() {
	WANT_AUTOMAKE=1.7 ./autogen.sh > /dev/null
	libtoolize --copy --force
	econf || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
