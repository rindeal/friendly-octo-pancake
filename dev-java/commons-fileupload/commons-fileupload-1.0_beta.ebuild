# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-fileupload/commons-fileupload-1.0_beta.ebuild,v 1.1 2003/03/22 11:55:07 absinthe Exp $

inherit jakarta-commons

MY_PV=${PV/_/-}-1

S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="The Commons FileUpload package makes it easy to add robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://jakarta.apache.org/commons/fileupload/index.html"
SRC_URI="http://www.apache.org/dist/jakarta/commons/fileupload/source/${PN}-${MY_PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"

src_compile() {
	jakarta-commons_src_compile myconf make
}
