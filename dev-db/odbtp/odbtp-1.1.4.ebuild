# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/odbtp/odbtp-1.1.4.ebuild,v 1.3 2010/03/31 20:44:11 mabi Exp $

inherit eutils

DESCRIPTION="ODBTP is a fast, efficient TCP/IP protocol for connecting to Win32-based databases from any platform."
HOMEPAGE="http://odbtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/odbtp/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch according to the README.64bitOS
	use amd64 && epatch "${FILESDIR}/${P}-amd64.patch"
}

src_compile() {
	# respect $CC (bug #243768)
	tc-export CC
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Install various documentation
	dodoc AUTHORS INSTALL NEWS README*
	if useq doc ; then
		dohtml -r docs/*
	fi
}
