# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.11-r1.ebuild,v 1.8 2003/02/13 08:55:14 vapier Exp $

DESCRIPTION="A nice command line todo list for developers"
SRC_URI="http://activelysecure.net/~alec/development/devtodo/0.1.11/${P}.tar.gz"
HOMEPAGE="http://activelysecure.net/~alec/development/devtodo/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.colourplain.patch
}

src_compile() {
	econf
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog QuickStart README TODO
}
