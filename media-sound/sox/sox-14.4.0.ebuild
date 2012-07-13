# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-14.4.0.ebuild,v 1.3 2012/07/13 10:58:10 aballier Exp $

EAPI=4
inherit eutils flag-o-matic autotools

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="alsa amr ao debug encode ffmpeg flac id3tag ladspa mad ogg openmp oss png pulseaudio sndfile static-libs twolame wavpack"

# libtool required for libltdl
RDEPEND=">=sys-devel/libtool-2.2.6b
	>=media-sound/gsm-1.0.12-r1
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	ao? ( media-libs/libao )
	encode? ( >=media-sound/lame-3.98.4 )
	ffmpeg? ( >=virtual/ffmpeg-0.9 )
	flac? ( media-libs/flac )
	id3tag? ( media-libs/libid3tag )
	ladspa? ( media-libs/ladspa-sdk )
	mad? ( media-libs/libmad )
	ogg? ( media-libs/libvorbis	media-libs/libogg )
	png? ( media-libs/libpng sys-libs/zlib )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	twolame? ( media-sound/twolame )
	wavpack? ( media-sound/wavpack )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	sed -i -e 's:CFLAGS="-g":CFLAGS="$CFLAGS -g":' configure || die #386027

	epatch \
		"${FILESDIR}"/${PN}-14.3.2-uclibc.patch \
		"${FILESDIR}"/${P}-ffmpeg.patch \
		"${FILESDIR}"/${P}-avcodec54.patch
	eautoreconf
}

src_configure() {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf \
		$(use_with alsa) \
		$(use_with amr amrnb) \
		$(use_with amr amrwb) \
		$(use_with ao) \
		$(use_enable debug) \
		$(use_with encode lame) \
		$(use_with ffmpeg) \
		$(use_with flac) \
		$(use_with id3tag) \
		$(use_with ladspa) \
		$(use_with mad) \
		$(use_enable openmp gomp) \
		$(use_with ogg oggvorbis) \
		$(use_with oss) \
		$(use_with png) \
		$(use_with pulseaudio) \
		$(use_with sndfile) \
		$(use_enable static-libs static) \
		$(use_with twolame) \
		$(use_with wavpack) \
		--with-distro="Gentoo"
}

src_install() {
	default
	# libltdl is used for loading plugins, keeping libtool files with empty
	# dependency_libs what otherwise would be -exec rm -f {} +
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
