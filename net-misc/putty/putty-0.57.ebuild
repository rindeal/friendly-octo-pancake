# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.57.ebuild,v 1.3 2005/02/21 08:43:26 taviso Exp $

inherit eutils

DESCRIPTION="UNIX port of the famous Telnet and SSH client"

HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="http://the.earth.li/~sgtatham/putty/latest/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="x86 alpha ~ppc ~sparc ~amd64"
IUSE="doc"

RDEPEND="=x11-libs/gtk+-1.2* virtual/x11"

DEPEND="${RDEPEND} dev-lang/perl"

src_unpack() {
	unpack ${A}

	ebegin "Generating Makefiles"
	cd ${S}; perl ${S}/mkfiles.pl || die
	eend $?

	ebegin "Setting CFLAGS"
	sed -i "s!-O2!${CFLAGS}!g" ${S}/unix/Makefile.gtk
	eend $?
}

src_compile() {
	cd ${S}/unix; emake -f Makefile.gtk || die "make failed"
}

src_install() {
	cd ${S}/doc

	doman plink.1 pterm.1 putty.1 puttytel.1 puttygen.1

	cd ${S}/unix

	dobin plink pterm putty puttytel psftp pscp puttygen

	cd ${S}

	dodoc README README.txt LICENCE CHECKLST.txt LATEST.VER website.url
	use doc && dodoc doc/*

	prepallman

	# install desktop file provided by Gustav Schaffter in #49577
	dodir /usr/share/applications
	insinto /usr/share/applications
	doins ${FILESDIR}/putty.desktop

	if test ! -c /dev/ptmx; then
		ewarn
		ewarn "The pterm application requires kernel UNIX98 PTY support to operate."
		ewarn
	fi
}
