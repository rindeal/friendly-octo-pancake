# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/maloc/maloc-1.5.ebuild,v 1.1 2011/04/16 06:53:17 jlec Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Minimal Abstraction Layer for Object-oriented C/C++ programs"
HOMEPAGE="http://www.fetk.org/codes/maloc/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE="doc mpi static-libs"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	sys-libs/readline
	doc? (
		media-gfx/graphviz
		app-doc/doxygen )
	mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch \
		"${FILESDIR}"/1.4-mpi.patch \
		"${FILESDIR}"/1.4-asneeded.patch \
		"${FILESDIR}"/1.4-doc.patch
	eautoreconf
}

src_configure() {
	local myconf
	use mpi && export CC="mpicc"
	use doc || myconf="${myconf} --with-doxygen= --with-dot="

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable mpi) \
		$(use_enable static-libs static) \
		--disable-triplet \
		--enable-shared \
		${myconf}
}

src_install() {
	# install libs and headers
	emake DESTDIR="${D}" install || die "make install failed"

	# install doc
	dohtml doc/index.html || die "failed to install html docs"
}
