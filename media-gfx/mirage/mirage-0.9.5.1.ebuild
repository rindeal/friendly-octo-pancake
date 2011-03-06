# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mirage/mirage-0.9.5.1.ebuild,v 1.3 2011/03/06 11:57:45 hwoarang Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit distutils eutils

DESCRIPTION="A fast and simple image viewer based on python and GTK+"
HOMEPAGE="http://mirageiv.berlios.de/"
SRC_URI="mirror://berlios/mirageiv/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	>=dev-python/pygtk-2.12"
DEPEND="${RDEPEND}
	sys-devel/gettext
	!media-plugins/banshee-mirage"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.3-stop_cleaning_up.patch
	distutils_src_prepare
}

src_install() {
	local DOCS="CHANGELOG README TODO TRANSLATORS"
	distutils_src_install

	rm -f "${D}"/usr/share/mirage/COPYING

	local x
	for x in ${DOCS}; do
		rm -f "${D}"/usr/share/mirage/${x}
	done
}
