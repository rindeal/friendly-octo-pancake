# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/oggtst/oggtst-0.0.ebuild,v 1.13 2004/06/25 00:15:58 agriffis Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="A tool for calculating ogg-vorbis playing time."
SRC_URI="http://gnometoaster.rulez.org/archive/${PN}.tgz"
HOMEPAGE="http://gnometoaster.rulez.org/"

DEPEND=">=media-libs/libao-0.8.0
	>=media-libs/libvorbis-1.0_rc2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 sparc"

src_compile() {

	econf || die
	make || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	dodoc AUTHORS ChangeLog README
}
