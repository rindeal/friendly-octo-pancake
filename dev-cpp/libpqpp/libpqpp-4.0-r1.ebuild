# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpqpp/libpqpp-4.0-r1.ebuild,v 1.5 2004/06/24 21:50:36 agriffis Exp $

inherit eutils

DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=">=dev-db/postgresql-7.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_compile() {
	sed -i \
		-e "s|^POSTGRES_HOME=/usr/local/pgsql$|POSTGRES_HOME=/usr|g" \
		Makefile
	emake || die "first"
	sed -i \
		-e "s|^POSTGRES_HOME=/usr$|POSTGRES_HOME=\${D}usr|g" \
		-e "s|^\tln -s .*$|\tln -s \$(soname) \$(POSTGRES_HOME)/lib/\$(TARGET).so|g" \
		Makefile
	emake || die "second"
}

src_install() {
	dodir /usr/lib /usr/include
	einstall install || die "Install failed"
}
