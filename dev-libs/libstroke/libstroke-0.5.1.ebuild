# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.5.1.ebuild,v 1.4 2004/02/01 21:43:29 avenj Exp $

inherit gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc alpha ~ppc ~amd64"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-libs/gtk+-1.2.10
	>=x11-base/xfree-4.0.3"

src_compile() {
	gnuconfig_update

	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README
}
