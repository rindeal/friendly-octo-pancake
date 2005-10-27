# Copyright 2005-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-2005.10.28.ebuild,v 1.1 2005/10/27 23:20:33 solar Exp $

MY_PV=${PV//./-}
MY_PV2=${PV//./}

DESCRIPTION="sparse - C semantic parser"
HOMEPAGE="http://kernel.org/pub/scm/devel/sparse/"
SRC_URI="http://www.codemonkey.org.uk/projects/git-snapshots/sparse/${PN}-${MY_PV}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/git-snapshot-${MY_PV2}

src_install() {
	newbin check sparse
	dolib libsparse.so
	dodoc FAQ LICENSE README
}
