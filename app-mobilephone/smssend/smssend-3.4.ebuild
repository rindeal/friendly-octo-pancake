# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smssend/smssend-3.4.ebuild,v 1.7 2010/02/23 15:13:07 josejx Exp $

inherit eutils autotools

DESCRIPTION="Universal SMS sender"
HOMEPAGE="None available" # was http://zekiller.skytech.org/smssend_menu_en.html
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-libs/skyutils-2.7"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Patch for Verizon Wireless support
	# absinthe@gentoo.org 12/16
	epatch "${FILESDIR}/${P}-verizon.diff"
	eautoreconf
}

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README todo.txt
}
