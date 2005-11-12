# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat-loki/lib-compat-loki-0.2.ebuild,v 1.1 2005/11/12 16:09:52 wolf31o2 Exp $

DESCRIPTION="Compatibility libc6 libraries for Loki games"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://www.blfh.de/gentoo/distfiles/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/lib-compat-loki/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86" # ppc
IUSE=""

RDEPEND="virtual/libc"

# I'm not quite sure if this is necessary:
RESTRICT="nostrip"

src_unpack() {
	unpack ${A}
	if use x86 || use amd64
	then
		cd ${S}/x86
	fi
	# rename the libs in order to _never_ overwrite any existing lib.
	mv libc-2.2.5.so loki_libc.so.6
	mv ld-2.2.5.so loki_ld-linux.so.2
	mv libnss_files-2.2.5.so loki_libnss_files.so.2
	mv libsmpeg-0.4.so.0 loki_libsmpeg-0.4.so.0
}

src_install() {
	if use x86 || use amd64
	then
		into /
		dolib.so x86/loki_ld-linux.so.2
		rm -f x86/loki_ld-linux.so.2
		into /usr
		dolib.so x86/*.so*
		preplib /usr
	fi
}
