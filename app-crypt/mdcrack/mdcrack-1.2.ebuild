# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mdcrack/mdcrack-1.2.ebuild,v 1.4 2009/02/10 16:15:32 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A MD4/MD5/NTML hashes bruteforcer."
HOMEPAGE="http://mdcrack.df.ru/"
SRC_URI="http://mdcrack.df.ru/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.diff \
		"${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	use ncurses || \
		sed -i -e 's/^NCURSES/#NCURSES/g' \
			-e 's/^LIBS/#LIBS/g' Makefile
	sed -i -e "/^CFLAGS/d" Makefile

	#endian
	emake CC="$(tc-getCC)" little || die "emake failed"
}

src_test() {
	make CC="$(tc-getCC)" fulltest || die "self test failed"
}

src_install() {
	dobin bin/mdcrack || die "dobin failed"
	dodoc BENCHMARKS CREDITS FAQ README TODO VERSIONS WWW
}
