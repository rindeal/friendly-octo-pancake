# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.2.1.ebuild,v 1.7 2003/07/15 13:24:53 todd Exp $

inherit gnome2

IUSE="spell"
DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha sparc hppa"

RDEPEND=">=gnome-base/libglade-2
	>=gnome-base/eel-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libbonobo-2
	=gnome-base/libgnomeprintui-2.2*
	>=gnome-base/ORBit2-2
	>=gnome-base/gnome-vfs-2.2
	>=app-text/scrollkeeper-0.3.11	
	spell? ( virtual/aspell-dict )"

DEPEND="${RDEPEND}
	>=dev-libs/popt-1.5
	>=gnome-base/gconf-1.2.1
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"
	
DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO"
