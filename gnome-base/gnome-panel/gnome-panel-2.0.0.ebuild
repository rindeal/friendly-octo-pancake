# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-panel/gnome-panel-2.0.0.ebuild,v 1.1 2002/06/10 14:03:10 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="The Panel for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/libxml2-2.4.22
	>=dev-libs/atk-1.0.0
	>=dev-libs/glib-2.0.0
    >=media-libs/libart_lgpl-2.3.8
	>=x11-libs/libwnck-0.13
	>=net-libs/linc-0.5.0
	>=media-libs/audiofile-0.2.3
	>=sys-libs/zlib-1.1.4
	>=app-text/scrollkeeper-0.3.4
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/gconf-1.1.11
	>=gnome-base/gnome-vfs-1.9.17
	>=gnome-base/gnome-desktop-2.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/libgnomeui-2.0.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

LIBTOOL_FIX="1"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS  README*"
SCHEMAS="clock.schemas panel-global-config.schemas panel-per-panel-config.schemas mailcheck.schemas pager.schemas tasklist.schemas fish.schemas"


