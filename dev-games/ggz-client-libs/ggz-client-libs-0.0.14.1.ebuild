# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ggz-client-libs/ggz-client-libs-0.0.14.1.ebuild,v 1.16 2012/02/19 13:38:00 scarabeus Exp $

EAPI=4

inherit games-ggz

DESCRIPTION="The client libraries for GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"

IUSE="debug static-libs"

RDEPEND="~dev-games/libggz-${PV}
	dev-libs/expat
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

PATCHES=( "${FILESDIR}"/${P}-destdir.patch )

src_configure() {
	games-ggz_src_configure \
		$(use_enable static-libs static)
}

src_install() {
	games-ggz_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
}
