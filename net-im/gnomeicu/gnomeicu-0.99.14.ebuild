# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.99.14.ebuild,v 1.3 2010/03/04 00:30:39 eva Exp $

inherit gnome2

DESCRIPTION="Gnome ICQ Client"
SRC_URI="mirror://sourceforge/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="spell"

# panel applet is unmaintained, do not enable it
RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=sys-libs/gdbm-1.8
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	spell? ( >=app-text/gtkspell-2.0.4 )
	x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.5
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.22
	sys-devel/gettext
	x11-proto/scrnsaverproto"

DOCS="AUTHORS ChangeLog CREDITS HACKING MAINTAINERS NEWS README README.SOCKS TODO"

pkg_setup() {
	G2CONF="${GCONF} --disable-schemas-install $(use_enable spell)"
}
