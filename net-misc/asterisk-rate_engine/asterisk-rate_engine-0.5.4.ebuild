# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-rate_engine/asterisk-rate_engine-0.5.4.ebuild,v 1.4 2006/11/23 20:37:34 vivo Exp $

inherit eutils

MY_PN="rate-engine"

DESCRIPTION="Asterisk application for least-cost routing"
HOMEPAGE="http://www.trollphone.org/files/"
SRC_URI="http://www.trollphone.org/files/${MY_PN}-${PV}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-libs/libpcre
	virtual/mysql
	>=net-misc/asterisk-1.0.5-r1
	!>=net-misc/asterisk-1.1.0"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# cflag fixes, install fixes and changes for asterisk-config
	epatch ${FILESDIR}/${MY_PN}-${PV}-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install samples || die "make install failed"

	dodoc COPYING COPYRIGHT ChangeLog
	dodoc DISCLAIMER NEWS README TODO
	dodoc *.sql *.conf*
}
