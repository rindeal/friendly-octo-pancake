# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libzvt/libzvt-2.0.1.ebuild,v 1.10 2004/06/17 01:45:13 mr_bones_ Exp $

inherit debug libtool

S=${WORKDIR}/${P}
DESCRIPTION="Zed's Virtual Terminal Library"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc "

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.5
	>=media-libs/libart_lgpl-2.3.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"


src_compile() {
	elibtoolize
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--libexecdir=/usr/lib \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		libexecdir=${D}/usr/lib \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die

	dodoc ABOUT* AUTHORS COPY* ChangeLog INSTALL NEWS README
	docinto libzvt
	dodoc libzvt/AUTHORS libzvt/BUGS libzvt/README libzvt/TODO
}





