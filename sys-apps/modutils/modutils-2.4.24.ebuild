# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.24.ebuild,v 1.16 2004/06/30 21:22:05 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="Standard kernel module utilities"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
KEYWORDS="x86 -amd64 ppc sparc ~alpha hppa ~mips"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/libc"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}
	cd ${S}/util
	cat ${FILESDIR}/alias.h.diff | patch -p0 || die
}

src_compile() {
	filter-flags -fPIC
	myconf=""
	# see bug #3897 ... we need insmod static, as libz.so is in /usr/lib
	#
	# Final resolution ... dont make it link against zlib, as the static
	# version do not want to autoload modules :(
	myconf="${myconf} --disable-zlib"

	econf \
		--prefix=/ \
		--disable-strip \
		--enable-insmod-static \
		${myconf} || die "./configure failed"
	if [ ${ARCH} = "hppa" ]
	then
		mymake="ARCH=hppa"
	fi

	emake ${mymake} || die "emake failed"
}

src_install() {
	if [ ${ARCH} = "hppa" ]
	then
		mymake="ARCH=hppa"
	fi
	einstall prefix="${D}" ${mymake} || die "make install failed"

	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}
