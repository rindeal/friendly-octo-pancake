# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.7.0.ebuild,v 1.1 2010/09/05 21:59:15 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Session manager for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfce4-session/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug consolekit gnome gnome-keyring policykit udev xfce_plugins_logout"

RDEPEND=">=dev-libs/dbus-glib-0.73
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/libwnck-2.22
	x11-apps/iceauth
	>=xfce-base/libxfce4util-4.7
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/xfconf-4.7
	>=xfce-base/xfce-utils-4.7
	consolekit? ( sys-auth/consolekit )
	gnome? ( gnome-base/gconf )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.22 )
	policykit? ( sys-auth/polkit )
	udev? ( sys-power/upower )
	xfce_plugins_logout? ( >=xfce-base/xfce4-panel-4.7.2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--docdir=${EPREFIX}/usr/share/doc/${PF}
		--disable-dependency-tracking
		--disable-static
		$(use_enable xfce_plugins_logout panel-plugin)
		$(use_enable gnome)
		$(use_enable gnome-keyring libgnome-keyring)
		$(xfconf_use_debug)
		--disable-hal
		$(use_enable udev upower)
		$(use_enable consolekit)
		$(use_enable policykit polkit)"
	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
}
