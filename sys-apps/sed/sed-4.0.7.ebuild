# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-4.0.7.ebuild,v 1.17 2004/07/01 21:38:52 eradicator Exp $

inherit gnuconfig

DESCRIPTION="Super-useful stream editor"
SRC_URI="mirror://gnu/sed/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/sed/sed.html"

KEYWORDS="x86 amd64 ppc sparc alpha hppa mips ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls static build"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	# Needed for mips and probably others
	gnuconfig_update

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf} || die "Configure failed"
	if ! use static ; then
		emake || die "Shared build failed"
	else
		emake LDFLAGS=-static || die "Static build failed"
	fi
}

src_install() {
	into /
	dobin sed/sed
	if ! use build
	then
		einstall || die "Install failed"
		dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS ANNOUNCE ChangeLog
		docinto examples
		dodoc ${FILESDIR}/dos2unix ${FILESDIR}/unix2dos

	else
		dodir /usr/bin
	fi

	rm -f ${D}/usr/bin/sed
	dosym ../../bin/sed /usr/bin/sed
}
