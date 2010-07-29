# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bdsup2sub/bdsup2sub-4.0.0.ebuild,v 1.2 2010/07/29 11:14:40 sbriesen Exp $

EAPI="3"

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A tool to convert and tweak bitmap based subtitle streams"
HOMEPAGE="http://bdsup2sub.javaforge.com/help.htm"
SRC_URI="http://sbriesen.de/gentoo/distfiles/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${PN}/${PV}"

java_prepare() {
	# Use XDG spec for INI file
	epatch "${FILESDIR}/${P}-xdg.diff"

	# copy build.xml
	cp -f "${FILESDIR}/build-${PV}.xml" build.xml || die
}

src_compile() {
	eant build $(use_doc)
}

src_install() {
	java-pkg_dojar dist/BDSup2Sub.jar
	java-pkg_dolauncher BDSup2Sub --main BDSup2Sub --java_args -Xmx256m
	newicon bin_copy/icon_32.png BDSup2Sub.png
	make_desktop_entry BDSup2Sub BDSup2Sub BDSup2Sub
	use doc && java-pkg_dojavadoc apidocs
	use source && java-pkg_dosrc src
}
