# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-newsticker/gkrellm-newsticker-0.3.5.ebuild,v 1.11 2004/06/24 22:56:29 agriffis Exp $

DESCRIPTION="A news headlines scroller for GKrellM2"
HOMEPAGE="http://gkrellm-newsticker.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc ~sparc alpha hppa"
IUSE=""

DEPEND="=app-admin/gkrellm-2*
		net-misc/curl"

S=${WORKDIR}/${PN}

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins newsticker.so || die
	dodoc README Changelog AUTHORS FAQ THEMES

	dodoc ${FILESDIR}/rdf-sources
}
