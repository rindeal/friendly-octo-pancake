# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/egressor/egressor-1.0-r1.ebuild,v 1.3 2004/06/19 10:38:26 kloeri Exp $

inherit eutils

DESCRIPTION="tool for checking router configuration"
HOMEPAGE="http://www.packetfactory.net/projects/egressor/"
SRC_URI="http://www.packetfactory.net/projects/${PN}/${PN}_release${PV}.tar.gz"

LICENSE="egressor"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND="<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"
RDEPEND="net-libs/libpcap
	dev-perl/Net-RawIP
	dev-lang/perl"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_compile() {
	cd client
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin client/egressor server/egressor_server.pl
	dodoc README client/README-CLIENT server/README-SERVER
}
