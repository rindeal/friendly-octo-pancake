# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.2.ebuild,v 1.8 2003/09/06 22:15:09 msterret Exp $

DESCRIPTION="replacement of the old unix crypt(1)"
HOMEPAGE="http://mcrypt.hellug.gr/"
SRC_URI="ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE="nls"

DEPEND=">=dev-libs/libmcrypt-2.5.1
	>=app-crypt/mhash-0.8.15"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS COPYING THANKS TODO
}
