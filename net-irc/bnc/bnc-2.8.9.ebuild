# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bnc/bnc-2.8.9.ebuild,v 1.2 2004/10/09 21:16:29 weeve Exp $

inherit eutils

MY_P=${P/-/}
DESCRIPTION="BNC (BouNCe) is used as a gateway to an IRC Server"
HOMEPAGE="http://gotbnc.com/"
SRC_URI="http://gotbnc.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~arm"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	mv mkpasswd bncmkpasswd
}

src_install() {
	dobin bnc bncchk bncsetup bncmkpasswd || die "dobin failed"
	dodoc CHANGES README example.conf motd || die "dodoc failed"
}

pkg_postinst() {
	einfo "You can find an example motd/conf file here:"
	einfo " /usr/share/doc/${PF}/{example.conf,motd}.gz"
}
