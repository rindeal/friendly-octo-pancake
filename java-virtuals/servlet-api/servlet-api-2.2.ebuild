# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.2.ebuild,v 1.14 2012/01/01 19:00:14 sera Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-java/tomcat-servlet-api:${SLOT}"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT}"
