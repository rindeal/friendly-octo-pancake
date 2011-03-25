# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.24.ebuild,v 1.1 2011/03/25 18:20:18 ssuominen Exp $

EAPI=4

DESCRIPTION="Provides an interface wrapping sockets into streams"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc static-libs"

RDEPEND="dev-libs/dvutil"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS="AUTHORS ChangeLog" # NEWS and README are useless
}

src_prepare() {
	sed -i -e 's/^\(SUBDIRS =.*\)doc\(.*\)$/\1\2/' Makefile.in || die
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +

	use doc && dohtml doc/html/*
}
