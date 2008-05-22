# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.46.ebuild,v 1.1 2008/05/22 01:32:02 lu_zero Exp $

inherit multilib flag-o-matic eutils python

#IUSE="jpeg mozilla png sdl static truetype"
IUSE="blender-game ffmpeg jpeg nls openal openexr png verse"
DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=dev-libs/openssl-0.9.6
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20070616-r1
			media-libs/x264 )
	jpeg? ( media-libs/jpeg )
	media-libs/tiff
	>=dev-lang/python-2.4
	nls? ( >=media-libs/freetype-2.0
			virtual/libintl
			>=media-libs/ftgl-2.1 )
	openal? ( media-libs/openal
			media-libs/freealut )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	>=media-libs/libsdl-1.2
	virtual/opengl"

DEPEND=">=dev-util/scons-0.98
	x11-libs/libXt
	x11-proto/inputproto
	${RDEPEND}"

blend_with() {
	local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
	fi
	if useq $1; then
		echo "WITH_BF_${UWORD}=1" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	else
		echo "WITH_BF_${UWORD}=0" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/blender-2.37-dirs.patch
	epatch "${FILESDIR}"/blender-2.44-scriptsdir.patch

	if use ffmpeg ; then
		cd "${S}"/extern
#		rm -rf ffmpeg libmp3lame x264
		cat <<- EOF >> "${S}"/user-config.py
		BF_FFMPEG="/usr"
		BF_FFMPEG_LIB="avformat avcodec swscale avutil"
		EOF
	fi
	# pass compiler flags to the scons build system
	# and set python version to current version in use
	python_version
	cat <<- EOF >> "${S}"/user-config.py
		CFLAGS += '${CFLAGS}'
		BF_PYTHON_VERSION="${PYVER}"
		BF_PYTHON_INC="/usr/include/python${PYVER}"
		BF_PYTHON_BINARY="/usr/bin/python${PYVER}"
		BF_PYTHON_LIB="python${PYVER}"
	EOF

}

src_compile() {
	for arg in 'openal' \
			'openexr' \
			'jpeg' \
			'ffmpeg' \
			'png' \
			'verse' \
			'nls international' \
			'blender-game gameengine'; do
		blend_with ${arg}
	done

	# scons uses -l differently -> remove it
	scons ${MAKEOPTS/-l[0-9]} || die \
	"!!! Please add ${S}/scons.config when filing bugs reports to bugs.gentoo.org"

	cd "${WORKDIR}"/install/linux2/plugins
	chmod 755 bmake
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe "${WORKDIR}"/install/linux2/blender

	dodir /usr/share/${PN}

	exeinto /usr/$(get_libdir)/${PN}/textures
	doexe "${WORKDIR}"/install/linux2/plugins/texture/*.so
	exeinto /usr/$(get_libdir)/${PN}/sequences
	doexe "${WORKDIR}"/install/linux2/plugins/sequence/*.so
	insinto /usr/include/${PN}
	doins "${WORKDIR}"/install/linux2/plugins/include/*.h

	if use nls ; then
		mv "${WORKDIR}"/install/linux2/.blender/{.Blanguages,.bfont.ttf} \
			"${D}"/usr/share/${PN}
		mv "${WORKDIR}"/install/linux2/.blender/locale \
			"${D}"/usr/share/locale
	fi

	mv "${WORKDIR}"/install/linux2/.blender/scripts "${D}"/usr/share/${PN}

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	dodoc INSTALL README
	dodoc "${WORKDIR}"/install/linux2/BlenderQuickStart.pdf
}

pkg_preinst(){
	if [ -h "${ROOT}/usr/$(get_libdir)/blender/plugins/include" ];
	then
		rm -f "${ROOT}"/usr/$(get_libdir)/blender/plugins/include
	fi
}
