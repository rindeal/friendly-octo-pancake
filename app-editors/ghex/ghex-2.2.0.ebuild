# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.2.0.ebuild,v 1.2 2003/02/13 06:40:24 vapier Exp $

inherit gnome2

IUSE="nls"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Hexadecimal editor"
HOMEPAGE="http://pluton.ijs.si/~jaka/gnome.html"

RDEPEND=">=gnome-base/gail-0.17
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprintui-2.2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	>=gnome-base/gconf-1.2"

SLOT="2"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="~x86"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"
