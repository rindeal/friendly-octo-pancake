# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-screensaver/gnome-screensaver-2.14.0.ebuild,v 1.2 2006/03/27 15:28:02 gustavoz Exp $

inherit eutils gnome2

DESCRIPTION="Replaces xscreensaver, integrating with the desktop."
HOMEPAGE="http://live.gnome.org/GnomeScreensaver"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug doc xinerama pam"

RDEPEND=">=sys-apps/dbus-0.35.2
		 >=gnome-base/gconf-2.6.1
		 >=x11-libs/gtk+-2.7.4
		 >=gnome-base/gnome-vfs-2.11
		 >=gnome-base/libgnomeui-2.11
		 >=gnome-base/libglade-2.5.0
		 >=gnome-base/gnome-menus-2.11.1
		 >=media-libs/libexif-0.6.12
		 >=dev-libs/glib-2.7.0
		 ||	(
		 		(
					x11-libs/libX11
					x11-libs/libXext
					x11-libs/libXrandr
					x11-libs/libXScrnSaver
					x11-proto/xextproto
					x11-proto/randrproto
					x11-proto/scrnsaverproto
					xinerama?	(
									x11-libs/libXinerama
									x11-proto/xineramaproto
								)
				)
				virtual/x11
			)
		 pam? ( sys-libs/pam )
		 !pam? ( sys-apps/shadow )
		 sys-devel/gettext"
		 #	xscreensaver? (x11-misc/xscreensaver)"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	# not sure what this does, thought it might cause
	# xscreensavers to show up, but it doesn't seem to work right
	# -AllanonJL
	#$(use_with xscreensaver xscreensaverdir) \
	#$(use_with xscreensaver xscreensaverhackdir=${ROOT}/usr/bin/)"

	G2CONF="${G2CONF} $(use_enable pam) $(use_enable doc) $(use_enable debug) \
			$(use_enable xinerama) --enable-locking"
}

src_install() {
	gnome2_src_install

	# If you are using shadow, you need to set the setuid bit on the dialog
	if ! use pam ; then
		fperms +s /usr/libexec/gnome-screensaver-dialog
	fi
}

pkg_postinst() {
	einfo "If you have xscreensaver installed, you probably want to disable it."
}
