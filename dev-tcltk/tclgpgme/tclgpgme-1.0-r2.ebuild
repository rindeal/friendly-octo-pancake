# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclgpgme/tclgpgme-1.0-r2.ebuild,v 1.1 2005/06/26 13:11:26 matsuu Exp $

inherit eutils

DESCRIPTION="Tcl/Tk libraries to gpgme."
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~ppc64 ~amd64"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	=app-crypt/gpgme-0.3.14-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.in.diff
	epatch ${FILESDIR}/${PV}-configure.diff
}

src_compile() {
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	econf --with-tcl=/usr/$(get_libdir) --with-tk=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README
}
