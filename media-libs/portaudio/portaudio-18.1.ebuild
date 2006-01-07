# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1.ebuild,v 1.16 2006/01/07 01:28:27 vapier Exp $

inherit eutils

MY_P=${PN}_v${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="18"
KEYWORDS="x86 sparc amd64 ppc ppc-macos ~mips hppa"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-use-fpic.patch
	use ppc-macos && cp ${FILESDIR}/${PN}-Makefile.macos ${S}/Makefile || \
	cp ${S}/Makefile.linux ${S}/Makefile
}

src_compile() {
	cd ${S}
	make sharedlib || die
}

src_install() {
	if ! use ppc-macos
	then
		dolib pa_unix_oss/libportaudio.so
	else
		dolib pa_mac_core/libportaudio.dylib
	fi

	insinto /usr/include
	doins pa_common/portaudio.h

	dodoc docs/*
}
