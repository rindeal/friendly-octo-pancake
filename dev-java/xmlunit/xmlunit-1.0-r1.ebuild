# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlunit/xmlunit-1.0-r1.ebuild,v 1.1 2005/11/24 03:37:22 compnerd Exp $

inherit eutils java-pkg

DESCRIPTION="XMLUnit extends JUnit and NUnit to enable unit testing of XML."
SRC_URI="mirror://sourceforge/${PN}/${P/-/}.zip"
HOMEPAGE="http://xmlunit.sourceforge.net/"
LICENSE="BSD"
SLOT="1"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.3
		>=app-arch/unzip-5.50-r1
		>=dev-java/ant-core-1.6
	  	  dev-java/junit
		jikes? ( >=dev-java/jikes-1.21 )
		source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	rm -f ${S}/lib/*.jar
}

src_compile() {
	local antflags="jar -Dclasspath=$(java-config -p junit)"

	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
