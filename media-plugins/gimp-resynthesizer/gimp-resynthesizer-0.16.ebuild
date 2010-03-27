# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-resynthesizer/gimp-resynthesizer-0.16.ebuild,v 1.1 2010/03/27 21:49:16 spatz Exp $

EAPI=2

inherit eutils toolchain-funcs

MY_PN="${PN#gimp-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GIMP plug-ing for texture synthesis"
HOMEPAGE="http://www.logarithmic.net/pfh/resynthesizer"
SRC_URI="http://www.logarithmic.net/pfh-files/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/gimp"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"

	tc-export CXX
}

src_install() {
	exeinto $(gimptool-2.0 --gimpplugindir)/plug-ins
	doexe resynth || die

	insinto $(gimptool-2.0 --gimpdatadir)/scripts
	doins smart-enlarge.scm smart-remove.scm || die

	dodoc README || die
}

pkg_postinst() {
	elog "The Resynthesizer plugin is accessible from the menu:"
	elog "* Filters -> Map -> Resynthesize"
	elog "* Filters -> Enhance -> Smart enlarge/sharpen/remove selection"
}
