# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/freemarker/freemarker-2.3.8.ebuild,v 1.4 2007/01/26 23:17:56 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION=" FreeMarker is a template engine; a generic tool to generate text output (anything from HTML to autogenerated source code) based on templates."
HOMEPAGE="http://freemarker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="freemarker"
SLOT="2.3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/jython
	dev-java/ant"
RDEPEND=">=virtual/jre-1.4
	=dev-java/servletapi-2.3*
	=dev-java/jaxen-1.1*
	dev-java/javacc"

GETJARS_ARG="servletapi-2.3,jaxen-1.1,jython"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	local antflags="-Djavacc.home=/usr/share/javacc/lib -lib $(java-pkg_getjars ${GETJARS_ARG})"
	eant clean jar $(use_doc) ${antflags}
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README.txt

	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc src/*
}
