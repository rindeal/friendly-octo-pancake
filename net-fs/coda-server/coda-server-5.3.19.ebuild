# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda-server/coda-server-5.3.19.ebuild,v 1.2 2003/07/13 11:51:18 aliz Exp $

IUSE=""
MY_P=${P/-server/}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Coda is an advanced networked filesystem developed at Carnegie Mellon Univ."
HOMEPAGE="http://www.coda.cs.cmu.edu"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/coda/src/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# partly based on the deps suggested by Mandrake's RPM, and/or on my current versions
# Also, definely needs coda.h from linux-headers.
DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-libs/lwp-1.9
	>=net-libs/rpc2-1.13
	>=sys-libs/rvm-1.6
	>=sys-libs/db-3
	>=sys-libs/ncurses-4
	>=sys-libs/readline-3
	>=sys-kernel/linux-headers-2.4"

src_unpack() {

	unpack ${A}

	cd ${S}
	# So that the venus initscript is Gentoo-compliant
	epatch ${FILESDIR}/${PF}-gentoo.patch

}

src_compile() {
#	Uncomment for db4 compatibility
#	OCFLAGS="${CFLAGS}"
#	CFLAGS="${CFLAGS} -lpthread"

	econf || die "configure failed"

#	Uncomment for db4 compatibility
#	mv Makeconf.setup Makeconf.setup.orig
#	sed -e "s:-lpthread::;s:-ldb:-ldb -lpthread:" \
#		Makeconf.setup.orig > Makeconf.setup
#	CFLAGS="${OCFLAGS}"

	MAKEOPTS="-j1" emake || die "emake failed"
}

src_install () {
	#these crazy makefiles dont seem to use DESTDIR, but they do use these... 
	# (except infodir, but no harm in leaving it there)
	# see Makeconf.setup in the package
	#
	#Also note that for Coda, need to do "make client-install" for client, or
	# "make server-install" for server.
	#...you can find out about this from ./configs/Makerules
	einstall \
		oldincludedir=${D}/usr/include server-install || die

	dodoc README* ChangeLog CREDITS LICENSE
}
