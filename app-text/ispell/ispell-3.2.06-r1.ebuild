# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ispell/ispell-3.2.06-r1.ebuild,v 1.6 2002/07/12 00:26:53 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ispell is a fast screen-oriented spelling checker"
SRC_URI="http://fmg-www.cs.ucla.edu/geoff/tars/${P}.tar.gz"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell.html"

DEPEND="virtual/glibc
	sys-devel/bison
	>=sys-libs/ncurses-5.2"

src_compile() {

	#This is easier and cleaner than sed'ing.
	#Also allows user to edit local.h.gentoo for language preference
	#cp ${FILESDIR}/local.h.gentoo ${S}/local.h

	make || die
}

src_install() {

	#Fix config.sh to install to ${D}
	cp config.sh config.sh.orig
	sed \
		-e "s:^\(BINDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(LIBDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN1DIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN4DIR='\)\(.*\):\1${D}\2:" \
		config.sh.orig > config.sh
	
	#Need to create the directories to install into
	#before 'make install'. Build environment **doesn't**
	#check for existence and create if not already there.
	dodir /usr/bin /usr/lib/ispell /usr/share/info \
		/usr/share/man/man1 /usr/share/man/man5

	make install || die "Installation Failed"

	dodoc Contributors README WISHES
}

