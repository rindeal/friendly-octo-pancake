# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.8.3.ebuild,v 1.4 2005/04/14 18:23:19 geoman Exp $

inherit gst-plugins

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 -mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
