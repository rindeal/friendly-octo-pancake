# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Justin Lambert <jlambert@eml.cc>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsorcery/ipsorcery-1.6.ebuild,v 1.2 2002/07/07 08:21:31 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ipsorcery allows you to generate IP, TCP, UDP, ICMP, and IGMP packets."
SRC_URI="http://www.legions.org/~phric/ipsorc-${PV}.tar.gz"
HOMEPAGE="http://www.legions.org/~phric/ipsorcery.html"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="gtk?	( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ipsorc-${PV}.tar.gz
	cd ${WORKDIR}
	mv ipsorc-${PV} ipsorcery-${PV}
}

src_install () {
	if use gtk; then
		make gtk || die
		dobin magic
	fi
	make con || die
	dobin ipmagic
}
