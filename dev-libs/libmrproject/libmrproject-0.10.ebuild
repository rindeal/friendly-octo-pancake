# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmrproject/libmrproject-0.10.ebuild,v 1.1 2003/09/21 18:46:15 spider Exp $

inherit gnome.org
IUSE="doc nls"


S=${WORKDIR}/${P}
DESCRIPTION="dependency libraries for MrProject"
HOMEPAGE="http://mrproject.codefactory.se/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

RDEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.19
	>=gnome-extra/libgsf-1.4.0"

DEPEND="nls? ( sys-devel/gettext )
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	local myconf
	use doc \
		&& myconf="--enable-gtk-doc" \
		|| myconf="--disable-gtk-doc"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf \
		--disable-maintainer-mode \
		${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeL* INSTALL NEWS  README*
}
