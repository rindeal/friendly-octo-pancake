# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.10.ebuild,v 1.1 2003/09/21 18:50:37 spider Exp $


inherit gnome2
DESCRIPTION="Project manager for Gnome2"
HOMEPAGE="http://mrproject.codefactory.se/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/glib-2.0.4
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.1
	=dev-libs/libmrproject-${PV}*
	>=gnome-base/gnome-vfs-2.0.2
	>=gnome-base/libgnomeprintui-2.1.9
	>=gnome-base/libbonoboui-2.0.0
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
DOCS="AUTHORS COPYING ChangeL* INSTALL NEWS  README*"
