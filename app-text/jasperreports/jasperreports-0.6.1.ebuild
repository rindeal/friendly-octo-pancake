# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jasperreports/jasperreports-0.6.1.ebuild,v 1.2 2004/09/01 08:08:23 axxo Exp $

inherit java-pkg

DESCRIPTION="JasperReports is a powerful report-generating tool that has the ability to deliver rich content onto the screen, to the printer or into PDF, HTML, XLS, CSV and XML files."
HOMEPAGE="http://jasperreports.sourceforge.net/"
SRC_URI="mirror://sourceforge/jasperreports/${P}-project.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.2
	dev-java/gnu-jaxp
	dev-java/commons-digester
	dev-java/commons-beanutils
	dev-java/commons-collections
	dev-java/commons-logging
	app-text/itext
	dev-java/poi"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/*.jar
	use doc && dohtml -r docs/*
}
