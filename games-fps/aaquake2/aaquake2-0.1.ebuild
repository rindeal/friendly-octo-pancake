# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/aaquake2/aaquake2-0.1.ebuild,v 1.11 2008/03/18 22:41:41 tupone Exp $

inherit eutils games

DESCRIPTION="text mode Quake II"
HOMEPAGE="http://www.jfedor.org/aaquake2/"
SRC_URI="mirror://idsoftware/source/q2source-3.21.zip
	http://www.jfedor.org/aaquake2/quake2-ref_softaa-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-libs/aalib"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/quake2-3.21/linux

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/quake2-3.21
	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${P}-glibc.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	cd linux
	sed -i \
		-e "s:GENTOO_DIR:$(games_get_libdir)/${PN}:" sys_linux.c \
		|| die "sed failed"
	sed -i \
		-e "s:/etc/quake2.conf:${GAMES_SYSCONFDIR}/${PN}.conf:" \
		sys_linux.c vid_so.c \
		|| die "sed failed"
}

src_compile() {
	mkdir -p releasei386-glibc/ref_soft
	make \
		GENTOO_CFLAGS="${CFLAGS}" \
		GENTOO_DATADIR="${GAMES_DATADIR}"/quake2/baseq2/ \
		build_release || die
}

src_install() {
	cd release*

	exeinto "$(games_get_libdir)"/${PN}
	doexe gamei386.so ref_softaa.so || die "doexe failed"
	dosym ref_softaa.so "$(games_get_libdir)"/${PN}/ref_softx.so
	dosym ref_softaa.so "$(games_get_libdir)"/${PN}/ref_soft.so
	exeinto "$(games_get_libdir)"/${PN}/ctf
	doexe ctf/gamei386.so || die "doexe failed"

	newgamesbin quake2 aaquake2 || die "newgamesbin failed"

	insinto "${GAMES_SYSCONFDIR}"
	echo "$(games_get_libdir)"/${PN} > ${PN}.conf
	doins ${PN}.conf || die "doins failed"

	prepgamesdirs
}
