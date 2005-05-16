# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/tiobench/tiobench-0.3.3-r2.ebuild,v 1.2 2005/05/16 17:56:56 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Portable, robust, fully-threaded I/O benchmark program"
HOMEPAGE="http://tiobench.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64"
IUSE=""

RDEPEND="virtual/libc
	dev-lang/perl"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.3.3-column-description-fix.patch

	sed -i \
		-e 's:/usr/local/bin:/usr/sbin:' tiobench.pl \
		|| die "sed tiobench.pl failed"
}

src_compile() {
	emake CC="$(tc-getCC)" DEFINES="-DLARGEFILES" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin tiotest tiobench.pl tiosum.pl || die "dosbin failed"
	dodoc BUGS ChangeLog README TODO || die "dodoc failed"
}
