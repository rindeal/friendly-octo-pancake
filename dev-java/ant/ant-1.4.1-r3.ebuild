# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.4.1-r3.ebuild,v 1.9 2002/12/07 06:18:52 jmorgan Exp $

S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ant/release/v${PV}/src/jakarta-ant-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"

pkg_setup() {
	if [ -z `java-config --java 2> /dev/null` ] ; then
		eerror "You don't have a default system VM."
		eerror "Use java-config to set one."
		die
	fi
}

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {

	cp ${FILESDIR}/gentoo-ant-1.4.1 src/ant

	exeinto /usr/bin
	doexe src/ant

	dojar build/lib/*.jar lib/*.jar || die
	
	dodoc LICENSE README WHATSNEW KEYS
	dohtml -r docs/*
}
