# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gnome/gkrellm-gnome-0.1.ebuild,v 1.9 2004/06/24 22:54:39 agriffis Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="Gnome hints configuration plugin for gkrellm"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://web.wt.net/~billw/gkrellm/Plugins.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
	gnome-base/gnome-libs"

src_compile() {

	make || die

}

src_install () {

	exeinto /usr/lib/gkrellm/plugins
	doexe src/gkrellm-gnome.so
	dodoc README Changelog COPYRIGHT INSTALL

}
