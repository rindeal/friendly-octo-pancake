# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-1.3-r1.ebuild,v 1.8 2002/10/20 18:40:23 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A console screen locker"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/console/vlock-1.3.tar.gz"
HOMEPAGE="ftp://ftp.ibiblio.org/pub/Linux/utils/console/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND="virtual/glibc"

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin vlock
	# Setuid root is required to unlock a screen with root's password.
	# This is "safe" because vlock drops privs ASAP; read the README
	# for more information.
	fperms 4711 /usr/bin/vlock
	doman vlock.1
	dodoc COPYING README
	insinto /etc/pam.d
	newins ${FILESDIR}/vlock.pamd vlock
}
