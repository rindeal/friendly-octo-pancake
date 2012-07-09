# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-2.6.0.ebuild,v 1.3 2012/07/09 20:04:05 dilfridge Exp $

EAPI=4

KDE_LINGUAS="af ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et eu fa fi fo fr fy ga gl ha he hi hr hsb
hu id is it ja ka kk km ko ku lb lo lt lv mi mk mn ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru
rw se sk sl sq sr sr@Latn ss sv ta te tg th tr tt uk uz uz@cyrillic ven vi wa xh zh_CN zh_HK zh_TW zu"

KDE_HANDBOOK="optional"
CMAKE_MIN_VERSION="2.8"
KDE_MINIMAL="4.8"

KDE_DOC_DIRS="doc-digikam doc-showfoto"

inherit kde4-base

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Digital photo management application for KDE"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="addressbook debug doc gphoto2 mysql semantic-desktop themedesigner +thumbnails video"

CDEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep libkipi)
	$(add_kdebase_dep marble plasma)
	$(add_kdebase_dep solid)
	media-libs/jasper
	media-libs/lcms:0
	media-libs/lensfun
	media-libs/libkface
	media-libs/libkgeomap
	media-libs/liblqr
	media-libs/libpgf
	media-libs/libpng
	media-libs/tiff
	sci-libs/clapack
	virtual/jpeg
	x11-libs/qt-gui[qt3support]
	|| ( x11-libs/qt-sql[mysql] x11-libs/qt-sql[sqlite] )
	addressbook? ( $(add_kdebase_dep kdepimlibs) )
	gphoto2? ( media-libs/libgphoto2 )
	mysql? ( virtual/mysql )
"
RDEPEND="${CDEPEND}
	$(add_kdebase_dep kreadconfig)
	media-plugins/kipi-plugins
	video? (
		|| (
			$(add_kdebase_dep mplayerthumbs)
			$(add_kdebase_dep ffmpegthumbs)
		)
	)
"
DEPEND="${CDEPEND}
	dev-libs/boost
	sys-devel/gettext
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}/core"

RESTRICT=test
# bug 366505

src_prepare() {
	# just to make absolutely sure
	rm -rf "${WORKDIR}/${MY_P}/extra" || die

	# prepare the handbook
	mkdir doc-digikam doc-showfoto || die
	echo "add_subdirectory( en )" > doc-digikam/CMakeLists.txt || die
	mv "${WORKDIR}/${MY_P}/doc/${PN}/digikam" doc-digikam/en || die
	echo "add_subdirectory( en )" > doc-showfoto/CMakeLists.txt || die
	mv "${WORKDIR}/${MY_P}/doc/${PN}/showfoto" doc-showfoto/en || die
	sed -i -e 's:../digikam/:../../doc-digikam/en/:g' doc-showfoto/en/index.docbook || die

	# prepare the translations
	mv "${WORKDIR}/${MY_P}/po" po || die
	find po -name "*.po" -and -not -name "digikam.po" -exec rm {} +

	echo "find_package(Msgfmt REQUIRED)" >> CMakeLists.txt || die
	echo "find_package(Gettext REQUIRED)" >> CMakeLists.txt || die
	echo "add_subdirectory( po )" >> CMakeLists.txt || die

	kde4-base_src_prepare

	if use handbook; then
		echo "add_subdirectory( doc-digikam )" >> CMakeLists.txt
		echo "add_subdirectory( doc-showfoto )" >> CMakeLists.txt
	fi
}

src_configure() {
	local backend

	use semantic-desktop && backend="Nepomuk" || backend="None"
	# LQR = only allows to choose between bundled/external
	local mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
		-DWITH_LQR=ON
		-DWITH_LENSFUN=ON
		-DGWENVIEW_SEMANTICINFO_BACKEND=${backend}
		$(cmake-utils_use_with addressbook KdepimLibs)
		-DWITH_MarbleWidget=ON
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with gphoto2)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable themedesigner)
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
		$(cmake-utils_use_enable mysql INTERNALMYSQL)
		$(cmake-utils_use_enable debug DEBUG_MESSAGES)
	)

	kde4-base_src_configure
}

src_compile() {
	local mytargets="all"
	use doc && mytargets+=" doc"

	kde4-base_src_compile ${mytargets}
}

src_install() {
	kde4-base_src_install

	if use doc; then
		# install the api documentation
		insinto /usr/share/doc/${PF}/html
		doins -r ${CMAKE_BUILD_DIR}/api/html/*
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use doc; then
		elog "The digikam api documentation has been installed at /usr/share/doc/${PF}/html"
	fi
}
