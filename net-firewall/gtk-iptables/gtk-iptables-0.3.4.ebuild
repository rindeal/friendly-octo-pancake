# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/gtk-iptables/gtk-iptables-0.3.4.ebuild,v 1.1 2003/03/14 10:06:48 seemant Exp $

IUSE="X gnome"

S=${WORKDIR}/${P}
DESCRIPTION="A GTK-1.2 front end for iptables"
HOMEPAGE="http://gtk-iptables.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="net-firewall/iptables"

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dosbin gtk-iptables
	doman doc/gtk-iptables.1
}
