# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.3.2.ebuild,v 1.7 2003/12/10 08:51:44 seemant Exp $

inherit libtool

DESCRIPTION="Console and font utilities"
HOMEPAGE="http://lct.sourceforge.net/"
SRC_URI="mirror://sourceforge/lct/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha ~mips"
IUSE="nls debug"

DEPEND="sys-devel/autoconf
	>=sys-apps/sed-4
	sys-devel/automake
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	find ./ -name 'Makefile.*' | xargs sed -i "s:doc ::"

	# GCC-3.3 Compile Fix
	epatch ${FILESDIR}/${P}-multi-line-string-fix.diff

	# better versions of this package's console.4 and console_ioctls.4
	epatch ${FILESDIR}/${PN}-no-man4pages.patch
}

src_compile() {
	acloca
	elibtoolize

	local myconf=""
	[ "$DEBUG" ] && myconf="--enable-debugging"
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"

	econf \
		`use_enable nls` \
		`use_enable debug debugging` || die

	emake all || die
}

src_install() {
	# DESTDIR does not work correct
	einstall || die

	dodoc BUGS COPYING* CREDITS ChangeLog NEWS README RELEASE TODO
	docinto txt
	dodoc doc/*.txt doc/README.*
	docinto sgml
	dodoc doc/*.sgml
	docinto txt/contrib
	dodoc doc/contrib/*
	docinto txt/dvorak
	dodoc doc/dvorak/*
	docinto txt/file-formats
	dodoc doc/file-formats/*

	rm -f doc/man/console.4* doc/man/console_ioctl*
	doman doc/man/*.[1-8]
}
