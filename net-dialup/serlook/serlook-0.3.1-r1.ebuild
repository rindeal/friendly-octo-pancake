# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.1-r1.ebuild,v 1.3 2005/12/27 10:13:12 mrness Exp $

inherit kde eutils

DESCRIPTION="serlook is a tool aimed to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-noarts.patch"

need-kde 3

src_install(){
	kde_src_install
	mv ${D}/usr/share/doc/serlook ${D}/usr/share/doc/${PF}
}