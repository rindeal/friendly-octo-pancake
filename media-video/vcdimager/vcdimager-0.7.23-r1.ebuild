# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.23-r1.ebuild,v 1.1 2009/01/08 11:02:26 ssuominen Exp $

EAPI=2

DESCRIPTION="GNU VCDimager"
HOMEPAGE="http://www.vcdimager.org/"
SRC_URI="http://www.vcdimager.org/pub/vcdimager/vcdimager-0.7/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="xml minimal"

RDEPEND=">=dev-libs/libcdio-0.71[-minimal]
	!minimal? ( dev-libs/popt )
	xml? ( >=dev-libs/libxml2-2.5.11 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RESTRICT="test"

src_configure() {
	local myconf

	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.
	use xml && myconf="--with-xml-prefix=/usr --disable-xmltest"
	use xml || myconf="--without-xml-frontend"

	econf \
		--disable-dependency-tracking \
		$(use_with !minimal cli-frontends) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ HACKING NEWS README THANKS TODO
}
