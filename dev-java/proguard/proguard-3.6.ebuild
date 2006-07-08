# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proguard/proguard-3.6.ebuild,v 1.2 2006/07/08 12:40:45 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Free Java class file shrinker, optimizer, and obfuscator."
HOMEPAGE="http://proguard.sourceforge.net/"
SRC_URI="mirror://sourceforge/proguard/${PN}${PV}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build.xml "${S}"
}

src_compile() {
	eant -lib `java-config -p sun-j2me-bin,ant-core` proguard
}

src_install() {
	cd "${S}"
	java-pkg_dojar dist/*

	if use doc; then
		java-pkg_dohtml docs/*
	fi

	if use examples; then
		java-pkg_dohtml -r examples
	fi
}

pkg_postinst() {

	einfo "Please see http://proguard.sourceforge.net/GPL_exception.html"
	einfo "for linking exception information about ${PN}"

}
