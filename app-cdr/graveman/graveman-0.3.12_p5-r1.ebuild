# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.3.12_p5-r1.ebuild,v 1.1 2007/01/27 17:27:28 dertobi123 Exp $

inherit gnome2 eutils

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://graveman.tuxfamily.org/"
SRC_URI="http://graveman.tuxfamily.org/sources/${PN}-${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug dvdr flac mp3 nls vorbis"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2.4
	>=dev-util/intltool-0.22
	dev-util/pkgconfig
	flac? ( >=media-libs/flac-1.1.0 )
	nls? ( sys-devel/gettext )
	mp3? ( >=media-libs/libid3tag-0.15
		>=media-libs/libmad-0.15 )
	vorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"
RDEPEND="${DEPEND}
	virtual/cdrtools
	>=app-cdr/cdrdao-1.1.9
	media-libs/libmng
	dvdr? ( >=app-cdr/dvd+rw-tools-5.20 )
	vorbis? ( >=media-sound/sox-12.17.0 )
	mp3? ( >=media-sound/sox-12.17.0 )
	nls? ( virtual/libintl )"

G2CONF="${G2CONF} \
	$(use_enable flac) \
	$(use_enable mp3) \
	$(use_enable vorbis ogg) \
	$(use_enable debug)"

S=${WORKDIR}/${P/_p/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/joliet-long.patch
	epatch ${FILESDIR}/rename.patch
	epatch ${FILESDIR}/fix-menu.patch
	if use mp3 || use vorbis; then
		epatch ${FILESDIR}/sox.patch
	fi
}
DOCS="AUTHORS ChangeLog INSTALL NEWS README* THANKS"
USE_DESTDIR="1"
