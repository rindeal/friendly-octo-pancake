# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmountains/xmountains-2.6.ebuild,v 1.2 2004/04/13 13:25:34 dholm Exp $

DESCRIPTION="Fractal terrains of snow-capped mountains near water"
HOMEPAGE="http://www.epcc.ed.ac.uk/~spb/${PN}/"
MY_P="${P/-/_}"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make CFLAGS="${CFLAGS} -DVROOT" || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README
	cp xmountains.man xmountains.1
	doman xmountains.1
}
