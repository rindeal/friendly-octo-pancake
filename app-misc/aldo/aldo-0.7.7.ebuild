# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.7.7.ebuild,v 1.1 2012/06/04 14:32:38 kensington Exp $

EAPI=4

DESCRIPTION="A morse tutor"
HOMEPAGE="http://www.nongnu.org/aldo"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/libao-0.8.5"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS )

sssrc_compile() {
	emake LDFLAGS="${LDFLAGS}" || die
}

sssrc_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS || die
}
