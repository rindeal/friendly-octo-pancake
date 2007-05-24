# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.4.1.ebuild,v 1.1 2007/05/24 13:32:49 drac Exp $

MY_P="gtk-xfce-engine-${PV}"
S="${WORKDIR}/${MY_P}"

inherit xfce44

XFCE_VERSION="4.4.1"

xfce44

DESCRIPTION="GTK+ Xfce4 theme engine"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	x11-libs/cairo
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_extra_package
