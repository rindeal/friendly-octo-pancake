# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxproxy/nxproxy-1.2.2.ebuild,v 1.1 2003/08/27 03:04:42 stuart Exp $

MY_P="${P}-5"
DESCRIPTION="X11 protocol compression library wrapper"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://www.nomachine.com/download/nxsources/${PN}/${MY_P}.tar.gz"
LICENSE="nxcomp"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=net-misc/nxcomp-1.2.2
        sys-devel/patch
		>=media-libs/jpeg-6b-r3
		>=sys-libs/glibc-2.3.2-r1
		>=sys-libs/zlib-1.1.4-r1"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	patch Makefile.in < ${FILESDIR}/1.2.2-Makefile.in.patch
}

src_compile() {
	./configure

	emake || die "compile problem"
}

src_install() {
	exeinto /usr/NX/bin
	doexe nxproxy

	dodoc README README-IPAQ README-VALGRIND VERSION LICENSE
}
