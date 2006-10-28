# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.8.2-r1.ebuild,v 1.1 2006/10/28 19:47:45 swegener Exp $

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="jpeg zlib threads ssl crypt v4l xinerama"

RDEPEND="zlib? ( sys-libs/zlib )
	jpeg? (	media-libs/jpeg )
	ssl? ( dev-libs/openssl )
	|| (
		(
			xinerama? ( x11-libs/libXinerama )
			x11-libs/libXfixes
			x11-libs/libXrandr
			x11-libs/libX11
			x11-libs/libXtst
			x11-libs/libXdamage
			x11-libs/libXext
		)
		virtual/x11
	)"

DEPEND="${RDEPEND}
	|| (
		(
			x11-libs/libXt
			xinerama? ( x11-proto/xineramaproto )
			x11-proto/trapproto
			x11-proto/recordproto
			x11-proto/xproto
			x11-proto/xextproto
		)
		virtual/x11
	)"

src_compile() {
	econf \
		$(use_with xinerama) \
		$(use_with ssl) \
		$(use_with ssl crypto) \
		$(use_with crypt) \
		$(use_with v4l) \
		$(use_with jpeg) \
		$(use_with zlib) \
		$(use_with threads pthread) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc x11vnc/{ChangeLog,README}
}
