# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/leptonica/leptonica-1.68.ebuild,v 1.1 2012/02/16 00:06:55 sbriesen Exp $

EAPI=4

inherit eutils autotools-utils

DESCRIPTION="C library for image processing and analysis"
HOMEPAGE="http://code.google.com/p/leptonica/"
SRC_URI="http://www.leptonica.com/source/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg png tiff webp utils zlib static-libs"

DEPEND="gif? ( media-libs/giflib )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

DOCS=( README version-notes )

src_prepare() {
	# unhtmlize docs
	local X
	for X in ${DOCS[@]}; do
		awk '/<\/pre>/{s--} {if (s) print $0} /<pre>/{s++}' \
			"${X}.html" > "${X}" || die 'awk failed'
		rm -f "${X}.html"
	done

	# see bug 297101, error when enabling png and zlib
	epatch "${FILESDIR}/${P}-zlib-include.patch"
}

src_configure() {
	# $(use_with webp libwebp) -> unknown
	# so use-flag just for pulling dependencies
	econf \
		$(use_with gif giflib) \
		$(use_with jpeg) \
		$(use_with png libpng) \
		$(use_with tiff libtiff) \
		$(use_with zlib) \
		$(use_enable utils programs) \
		$(use_enable static-libs static)
}
