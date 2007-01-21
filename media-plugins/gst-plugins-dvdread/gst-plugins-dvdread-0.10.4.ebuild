# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvdread/gst-plugins-dvdread-0.10.4.ebuild,v 1.10 2007/01/21 22:28:20 kloeri Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~sh sparc x86"
IUSE=""

RDEPEND="media-libs/libdvdread
	>=media-libs/gstreamer-0.10.3
	>=media-libs/gst-plugins-base-0.10.3"
DEPEND="${RDEPEND}"
