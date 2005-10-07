# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spim/spim-7.1.ebuild,v 1.3 2005/10/07 09:04:32 eradicator Exp $

inherit eutils

DESCRIPTION="MIPS Simulator"
HOMEPAGE="http://www.cs.wisc.edu/~larus/spim.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~ppc-macos ~x86"
IUSE="X"

RDEPEND="X? ( virtual/x11 )"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4
		x11-base/xorg-x11"

RESTRICT="maketest"

src_unpack() {
	unpack ${A}
	cd ${S}

	# The font issue is still with us (Bug #73510)
	epatch ${FILESDIR}/${P}-font.patch
}

src_compile() {
	./Configure || die "Configure Failed!"

	sed -i \
		-e 's:@make:@$(MAKE):' \
		-e "s:\(BIN_DIR = \).*$:\1/usr/bin:" \
		-e "s:\(MAN_DIR = \).*$:\1/usr/share/man:" \
		-e "s:\(EXCEPTION_DIR = \).*$:\1/var/lib/spim:" \
			Imakefile

		# Tests need these changes, however, they require make install
		# -e "s:\(CSH = \).*$:\1bash:" \
		# -e "s:tail -2:tail -n2:" Imakefile

	xmkmf
	emake spim || die "Unable to compile spim"
	if [ $(use X) ] ; then
		emake xspim || die "Unable to compile xspim"
	fi
}

src_install() {
	dodir /var/lib/spim
	make install DESTDIR=${D} || die "Unable to install spim"

	newman spim.man spim.1
	use X && newman xspim.man xspim.1
	dodoc BLURB README VERSION ChangeLog Documentation/*
}
