# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mesa-progs/mesa-progs-6.4.1.ebuild,v 1.10 2006/02/14 20:40:14 corsair Exp $

inherit toolchain-funcs

MY_PN="${PN/m/M}"
MY_PN="${MY_PN/-progs}"
MY_P="${MY_PN}-${PV}"
LIB_P="${MY_PN}Lib-${PV}"
PROG_P="${MY_PN}Demos-${PV}"
DESCRIPTION="Mesa's OpenGL utility and demo programs"
HOMEPAGE="http://mesa3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/mesa3d/${LIB_P}.tar.bz2
	mirror://sourceforge/mesa3d/${PROG_P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/glut
	virtual/opengl
	virtual/glu"

DEPEND="${DEPEND}"

S=${WORKDIR}/Mesa-${PV}

pkg_setup() {
	if [[ ${KERNEL} == "FreeBSD" ]]; then
		CONFIG="freebsd"
	elif use x86; then
		CONFIG="linux-dri-x86"
	elif use amd64; then
		CONFIG="linux-dri-x86-64"
	elif use ppc; then
		CONFIG="linux-dri-ppc"
	else
		CONFIG="linux-dri"
	fi
}

src_unpack() {
	HOSTCONF="${S}/configs/${CONFIG}"

	unpack ${A}
	cd ${S}

	# Kill this; we don't want /usr/X11R6/lib ever to be searched in this
	# build.
	echo "EXTRA_LIB_PATH =" >> ${HOSTCONF}

	echo "OPT_FLAGS = ${CFLAGS}" >> ${HOSTCONF}
	echo "CC = $(tc-getCC)" >> ${HOSTCONF}
	echo "CXX = $(tc-getCXX)" >> ${HOSTCONF}

	# Just executables here, no need to compile with -fPIC
	echo "PIC_FLAGS =" >> ${HOSTCONF}
}

src_compile() {
	cd ${S}/configs
	ln -s ${CONFIG} current

	cd ${S}/progs/xdemos

	emake glxinfo
	emake glxgears
}

src_install() {
	dobin ${S}/progs/xdemos/glxgears
	dobin ${S}/progs/xdemos/glxinfo
}
