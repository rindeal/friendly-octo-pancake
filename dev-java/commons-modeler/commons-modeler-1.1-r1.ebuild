# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-modeler/commons-modeler-1.1-r1.ebuild,v 1.4 2007/04/08 12:28:47 corsair Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A lib to make the setup of Java Management Extensions easier"
SRC_URI="mirror://apache/jakarta/commons/modeler/source/modeler-1.1-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/modeler/"
LICENSE="Apache-1.1"
SLOT="0"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/sun-jmx-1.2.1
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-digester-1.4.1
	>=dev-java/xalan-2.5.1"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

KEYWORDS="~amd64 ppc64 ~x86"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Setup the build environment
	echo "commons-digester.jar=$(java-pkg_getjar commons-digester commons-digester.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "jmx.jar=$(java-pkg_getjar sun-jmx jmxri.jar)" >> build.properties
	echo "jmxtools.jar=$(java-pkg_getjar sun-jmx jmxtools.jar)" >> build.properties
	echo "jaxp.xalan.jar=$(java-pkg_getjars xalan)" >> build.properties
	echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
	mkdir dist
}

EANT_BUILD_TARGET="prepare jar"

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc RELEASE-NOTES-1.1.txt RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc docs/*
	use source && java-pkg_dosrc src/java/*
}
