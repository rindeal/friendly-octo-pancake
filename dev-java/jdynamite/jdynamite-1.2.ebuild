# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdynamite/jdynamite-1.2.ebuild,v 1.2 2006/07/23 13:04:29 nelchael Exp $

inherit java-pkg-2 java-ant-2

MY_PV="${PV/./_}"
DESCRIPTION="Dynamic Template in Java"
HOMEPAGE="http://jdynamite.sourceforge.net/doc/jdynamite.html"
SRC_URI="mirror://sourceforge/${PN}/${PN}${MY_PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.2
	>=dev-java/gnu-regexp-1.0.8"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {

	unpack "${A}"

	# Yuck! Already compiled!
	cd "${S}"
	rm -fr lib/*
	rm -fr cb
	rm -fr src/gnu

	cp "${FILESDIR}/${PV}-build.xml" "${S}/build.xml"

}

src_compile() {

	mkdir "${S}/build" || die "mkdir failed"

	eant -lib $(java-pkg_getjars gnu-regexp-1) jar || die "ant failed"

}

src_install() {

	java-pkg_dojar "${PN}.jar"

	if use doc; then
		java-pkg_dohtml -r doc/*
	fi

	use source && java-pkg_dosrc ${S}/src/cb

}
