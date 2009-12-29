# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mosaik/mosaik-1.0.1367.ebuild,v 1.2 2009/12/29 20:54:08 fauli Exp $

EAPI="2"

DESCRIPTION="A reference-guided aligner for next-generation sequencing technologies"
HOMEPAGE="http://code.google.com/p/mosaik-aligner/"
SRC_URI="http://mosaik-aligner.googlecode.com/files/Mosaik-${PV}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-source"

src_compile() {
	emake -C src || die
#	emake -C MosaikTools/c++ || die
#	emake -C MosaikTools/perl || die
}

src_install() {
	dobin bin/* || die

	insinto /usr/share/${PN}
	doins -r MosaikTools || die

	dodoc README Mosaik-1.0-Documentation.pdf
}
