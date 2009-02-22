# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libtomoe-gtk/libtomoe-gtk-0.6.0-r1.ebuild,v 1.1 2009/02/22 21:16:40 eva Exp $

EAPI="2"

inherit autotools

MY_P="tomoe-gtk-${PV}"
DESCRIPTION="Tomoe GTK+ interface widget library"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge/tomoe/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +gucharmap"

RDEPEND=">=app-i18n/tomoe-0.6.0
	>=dev-python/pygtk-2
	>=dev-python/pygobject-2
	gucharmap? ( >=gnome-extra/gucharmap-1.4.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Fix compilation with gucharmap-2.24, bug #243160
	epatch "${FILESDIR}/${P}-gucharmap2.patch"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_with gucharmap)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
}
