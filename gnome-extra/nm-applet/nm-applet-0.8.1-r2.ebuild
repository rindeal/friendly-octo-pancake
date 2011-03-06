# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.8.1-r2.ebuild,v 1.4 2011/03/06 23:08:10 nirbheek Exp $

EAPI="2"

inherit gnome2 eutils autotools

MY_PN="${PN/nm-applet/network-manager-applet}"

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth"

# FIXME: bluetooth is automagic
# XXX: depend on dbus-1.2.6 when it goes stable
RDEPEND=">=dev-libs/glib-2.16:2
	>=dev-libs/dbus-glib-0.74
	>=sys-apps/dbus-1.2
	>=x11-libs/gtk+-2.18:2
	>=gnome-base/gconf-2.20:2
	>=gnome-extra/polkit-gnome-0.92
	>=x11-libs/libnotify-0.4.3
	>=gnome-base/libglade-2:2.0
	>=gnome-base/gnome-keyring-2.20

	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-${PV}
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	net-misc/mobile-broadband-provider-info
	bluetooth? ( >=net-wireless/gnome-bluetooth-2.27.6 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"
# USE_DESTDIR="1"

src_prepare() {
	# Fix compilation with DGSEAL_ENABLE gentoo bug #330363
	epatch "${FILESDIR}/${P}-fix-compilation-with-DGSEAL_ENABLE.patch"
	epatch "${FILESDIR}/${P}-fix-bluetooth-dep.patch"

	eautoreconf
}

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup () {
	G2CONF="${G2CONF}
		--disable-more-warnings
		--localstatedir=/var"
}
