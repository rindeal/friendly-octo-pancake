# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/am-utils/am-utils-6.0.9-r1.ebuild,v 1.9 2004/11/05 10:24:09 mr_bones_ Exp $

inherit eutils

DESCRIPTION="amd automounter and utilities"
HOMEPAGE="http://www.am-utils.org"
SRC_URI="ftp://ftp.am-utils.org/pub/am-utils/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="ldap"

DEPEND="virtual/libc
	ldap? ( >=net-nds/openldap-1.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/am-utils-gdbm.patch"
}

src_compile() {
	econf\
		$(use_with ldap) \
		--sysconfdir=/etc/amd \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc/amd
	doins ${FILESDIR}/amd.{conf,net}

	exeinto /etc/init.d ; newexe "${FILESDIR}/amd.rc" amd
}
