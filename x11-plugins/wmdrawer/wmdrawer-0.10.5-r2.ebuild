# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdrawer/wmdrawer-0.10.5-r2.ebuild,v 1.7 2008/12/02 10:51:54 s4t4n Exp $

inherit eutils

IUSE=""
DESCRIPTION="dockapp which provides a drawer (retractable button bar) to launch applications"
SRC_URI="http://people.easter-eggs.org/~valos/wmdrawer/${P}.tar.gz"
HOMEPAGE="http://people.easter-eggs.org/~valos/wmdrawer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk+-2.patch

	# Honour Gentoo CFLAGS
	sed -i -e "s|-O3|${CFLAGS}|" Makefile || die

	# Fix LDFLAGS ordering per bug #248640
	sed -i 's/$(CC) $(LDFLAGS) -o $@ $(OBJS)/$(CC) -o $@ $(OBJS) $(LDFLAGS)/' Makefile || die

	# Do not auto-strip binaries
	sed -i 's/	strip $@//' Makefile || die
}

src_install() {
	dobin wmdrawer
	dodoc README TODO AUTHORS ChangeLog wmdrawerrc.example
	doman wmdrawer.1
}
