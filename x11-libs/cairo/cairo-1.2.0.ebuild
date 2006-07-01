# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.2.0.ebuild,v 1.1 2006/07/01 08:06:29 cardoe Exp $

inherit eutils autotools

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc glitz pdf png svg X"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.1.4
	X? (	|| (
			( x11-libs/libXrender
			x11-libs/libXext
			x11-libs/libX11 )
			virtual/x11
		)
		virtual/xft
	)
	glitz? ( >=media-libs/glitz-0.5.1 )
	png? ( media-libs/libpng )
	pdf? (	>=app-text/poppler-bindings-0.4.1
		x11-libs/pango
		>=x11-libs/gtk+-2 )
	svg? ( dev-libs/libxml2 )
	!<x11-libs/cairo-0.2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	X? ( || ( x11-proto/renderproto virtual/x11 ) )
	doc? (	>=dev-util/gtk-doc-1.3
		 ~app-text/docbook-xml-dtd-4.2 )"

src_compile() {
	echo
	echo
	echo
	ewarn "This compiles but with tons of warnings.. but some Gentoo devs want this in masked.."
	echo
	echo
	echo
	echo

	econf $(use_enable X xlib) $(use_enable doc gtk-doc) \
		  $(use_enable png) $(use_enable svg) $(use_enable pdf) \
		  $(use_enable glitz) --enable-freetype --enable-ps \
		  || die "configure failed"

	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
