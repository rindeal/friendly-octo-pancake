# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdots/wmdots-0.2_beta.ebuild,v 1.9 2004/06/24 23:08:37 agriffis Exp $

MY_P=wmdots-0.2beta
S=${WORKDIR}/${PN}
DESCRIPTION="Multi shape 3d rotating dots"
SRC_URI="http://dockapps.org/download.php/id/153/${MY_P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/116"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -ppc"
SLOT="0"

IUSE=""

DEPEND="virtual/x11"


src_compile() {

	emake || die

}

src_install () {

	dobin ${S}/wmdots
}
