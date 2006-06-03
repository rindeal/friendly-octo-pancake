# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-2.1.0.ebuild,v 1.1 2006/06/03 00:40:35 chainsaw Exp $

inherit toolchain-funcs eutils

MY_P="${P/xchat-/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="http://dev.gentoo.org/~chainsaw/xsys/download/${MY_P}.tar.bz2 mirror://gentoo/${MY_P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~chainsaw/xsys/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="audacious buttons xmms"

DEPEND="|| (
		>=net-irc/xchat-2.4.0
		>=net-irc/xchat-gnome-0.4
	)
	sys-apps/pciutils
	audacious? ( media-sound/audacious )
	xmms? ( media-sound/xmms )"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2 -Wall:${CFLAGS} -Wall:" ${S}/Makefile
	if use buttons; then
		sed -i -e "s:#BUTTON:BUTTON:" ${S}/Makefile
	fi
	if use audacious; then
		sed -i -e "s:# FOR AUDACIOUS # ::g" ${S}/Makefile
	elif use xmms; then
		sed -i -e "s:# FOR XMMS # ::g" ${S}/Makefile
	fi
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so || die "doexe failed"

	exeinto /usr/$(get_libdir)/xchat-gnome/plugins
	doexe xsys-${PV}.so || die "doexe failed"

	dodoc ChangeLog README || die "dodoc failed"
}
