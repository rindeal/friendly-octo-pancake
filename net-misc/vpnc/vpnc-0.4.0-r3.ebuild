# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.4.0-r3.ebuild,v 1.3 2007/08/07 03:07:43 vapier Exp $

inherit eutils linux-info

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://www.unix-ag.uni-kl.de/~massar/${PN}/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libgcrypt-1.1.91
	>=sys-apps/iproute2-2.6.19.20061214"

pkg_setup()	 {
	local CONFIG_CHECK="TUN"
	check_extra_config
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO VERSION
	keepdir /var/run/vpnc
	dobin pcf2vpnc
	dobin cisco-decrypt
	newinitd "${FILESDIR}/vpnc.init" vpnc
}

pkg_postinst() {
	elog "You can generate a configuration file from the original Cisco profiles of your"
	elog "connection by using /usr/bin/pcf2vpnc to convert the .pcf file"
	elog "A guide is to be found in http://www.gentoo.org/doc/en/vpnc-howto.xml"
}
