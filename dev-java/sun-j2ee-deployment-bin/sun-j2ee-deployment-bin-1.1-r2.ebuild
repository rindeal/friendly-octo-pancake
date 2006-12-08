# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2ee-deployment-bin/sun-j2ee-deployment-bin-1.1-r2.ebuild,v 1.1 2006/12/08 22:00:59 caster Exp $

inherit java-pkg-2

MY_PV=${PV/./_}

CLASS_URI="j2ee_deployment-${MY_PV}-fr-class.zip"
DOC_URI="j2ee_deployment-${MY_PV}-fr-doc.zip"

DESCRIPTION="J2EE Application Deployment Specification"
HOMEPAGE="http://java.sun.com/j2ee/tools/deployment/"
SRC_URI="${CLASS_URI}
	doc? ( ${DOC_URI} )"
LICENSE="sun-bcla-j2ee-deployment"
SLOT="1.1"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
RESTRICT="fetch"

S=${WORKDIR}

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=J2EE_DEPLOYMENT-1.1-FR-CLASS-G-F&SiteId=JSC&TransactionId=noreg"
DOWNLOAD_URL_DOC="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=J2EE_DEPLOYMENT-1.1-FR-DOC-G-F&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download \"J2EE Deployment API Class Files 1.1\" - ${CLASS_URI}"
	einfo "from ${HOMEPAGE} and move it to ${DISTDIR}"
	einfo "Direct URL: ${DOWNLOAD_URL}"
	if use doc; then
		einfo "Also download \"API Documentation 1.1\" - ${DOC_URI}"
		einfo "from ${HOMEPAGE} and move it to ${DISTDIR}"
		einfo "Direct URL: ${DOWNLOAD_URL_DOC}"
	fi
}

src_compile() {
	jar cvf ${PN}.jar javax || die "Failed to create the ${PN}.jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dojavadoc doc
}
