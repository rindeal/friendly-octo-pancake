# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/roxterm/roxterm-1.2.3.ebuild,v 1.1 2006/07/29 05:29:30 compnerd Exp $

inherit eutils

DESCRIPTION="A terminal emulator designed to integrate with the ROX environment"
HOMEPAGE="http://roxterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/roxterm/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.6
		 >=x11-libs/gtk+-2.6
		 >=sys-apps/dbus-0.35
		 >=x11-libs/vte-0.11.11
		 >=gnome-base/libglade-2"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.20"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-1.2.3-new-button.patch
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
