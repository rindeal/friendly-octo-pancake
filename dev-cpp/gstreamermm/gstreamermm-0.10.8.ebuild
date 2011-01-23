# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gstreamermm/gstreamermm-0.10.8.ebuild,v 1.1 2011/01/23 19:28:22 eva Exp $

EAPI="3"

inherit gnome2 eutils

DESCRIPTION="C++ interface for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/bindings/cplusplus.html"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="
	>=media-libs/gstreamer-0.10.30
	>=media-libs/gst-plugins-base-0.10.30
	>=dev-cpp/glibmm-2.21.1:2
	>=dev-cpp/libxmlpp-2.14:2.6
	>=dev-libs/libsigc++-2:2
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? (
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-vorbis:0.10
		media-plugins/gst-plugins-x:0.10 )
"

src_test() {
	# explicitly allow parallel make of tests: they are not built in
	# src_compile() and indeed we'd slow down tremendously to run this
	# serially.
	emake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" libdocdir=/usr/share/doc/${PF} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	find "${D}" -name '*.la' -delete || die "removal of *.la files failed"
}
