# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kreversi/kreversi-4.1.3.ebuild,v 1.4 2009/01/04 15:19:54 scarabeus Exp $

EAPI="2"
KMNAME=kdegames
inherit games-ggz kde4-meta

DESCRIPTION="KDE Board Game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

src_prepare() {
	# cmake is doing this really weird
	sed -i \
		-e "s:register_ggz_module:#register_ggz_module:g" \
		${PN}/CMakeLists.txt || die "ggz removal failed"
}

src_install() {
	kde4-meta_src_install
	# and also we have to prepare the ggz dir
	mkdir -p "${D}"/usr/share/ggz/modules
	cp ${PN}/module.dsc "${D}"/usr/share/ggz/modules/${PN}.dsc
	kde4-meta_src_prepare
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	games-ggz_pkg_postinst
}

pkg_postrm() {
	kde4-meta_pkg_postrm
	games-ggz_pkg_postrm
}
