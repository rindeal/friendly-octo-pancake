# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.15.ebuild,v 1.7 2005/01/12 22:28:32 gustavoz Exp $

inherit eutils

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${PF}-gentoo.tar.bz2
	mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~lu_zero/distfiles/${PF}-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ppc ppc64 x86 ~sparc"
IUSE="nls static readline debug"

DEPEND=">=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patches
	aclocal || die "aclocal failed"
	libtoolize --copy --force || die "libtoolize failed"
	automake || die "automake failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	econf \
		$(use_with readline) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable static all-static) \
		--disable-Werror \
		${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO
	dodoc doc/{API,FAQ,FAT,USER.jp}
}
