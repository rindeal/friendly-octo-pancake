# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon+smp/wmmon+smp-1.0-r1.ebuild,v 1.7 2004/06/24 23:13:45 agriffis Exp $

IUSE=""

S=${WORKDIR}/wmmon.app
S2=${S}/wmmon
DESCRIPTION="Dockapp CPU monitor resembling Xosview, support for smp"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/wmmon+smp.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_compile() {
	cd ${S2}
	emake || die
}

src_install () {
	exeinto /usr/bin
	cp ${S2}/wmmon ${S2}/wmmon+smp
	doexe ${S2}/wmmon+smp
	dodoc ${S}/README ${S}/COPYING ${S}/INSTALL
}
