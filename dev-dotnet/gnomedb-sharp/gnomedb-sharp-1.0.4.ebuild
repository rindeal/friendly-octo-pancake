# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnomedb-sharp/gnomedb-sharp-1.0.4.ebuild,v 1.3 2005/01/01 17:47:02 eradicator Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		=dev-dotnet/art-sharp-${PV}*
		=dev-dotnet/gda-sharp-${PV}*
		=dev-dotnet/gnome-sharp-${PV}*
		>=gnome-extra/libgnomedb-1.0.0"

GTK_SHARP_COMPONENT_BUILD_DEPS="art gda gnome"
