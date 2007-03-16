# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrkit/cdrkit-1.0.ebuild,v 1.8 2007/03/16 15:29:12 pylon Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A suite of programs for recording CDs and DVDs, blanking CD-RW media, creating ISO-9660 filesystem images, extracting audio CD data, and more."
HOMEPAGE="http://cdrkit.org/"
SRC_URI="http://cdrkit.org/releases/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-util/cmake-2.4
	!app-cdr/cdrtools
	sys-libs/libcap"

PROVIDE="virtual/cdrtools"

src_compile() {
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC))

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym /usr/bin/wodim /usr/bin/cdrecord

	cd ${S}
	dodoc ABOUT Changelog FAQ FORK START TODO VERSION

	cd ${S}/doc/READMEs
	dodoc README*

	cd ${S}/doc/wodim
	dodoc README*

	cd ${S}/doc/cdda2wav
	docinto cdda2wav
	dodoc FAQ Frontends HOWTOUSE README TODO

	cd ${S}/doc/mkisofs
	docinto mkisofs
	dodoc *

	cd ${S}/doc/plattforms/
	docinto platforms
	dodoc README.{linux,parallel}

	cd ${S}
	insinto /etc
	newins cdrecord/wodim.dfl wodim.conf

	cd ${S}
	insinto /usr/include/scsilib
	doins include/*.h
	insinto /usr/include/scsilib/scg
	doins include/scg/*.h
}
