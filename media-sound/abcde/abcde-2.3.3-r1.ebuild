# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcde/abcde-2.3.3-r1.ebuild,v 1.3 2009/01/10 10:59:13 beandog Exp $

DESCRIPTION="A Better CD Encoder"
HOMEPAGE="http://code.google.com/p/abcde/"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cdparanoia id3 vorbis flac speex lame musepack replaygain"

RDEPEND="
	>=media-sound/normalize-0.7.4
	id3? (
		>=media-sound/id3-0.12
		media-sound/id3v2
	)
	media-sound/cd-discid
	cdparanoia? ( media-sound/cdparanoia )
	vorbis? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	speex? ( media-libs/speex )
	lame? ( media-sound/lame )
	musepack? ( media-sound/mppenc )
	replaygain? ( vorbis? ( media-sound/vorbisgain ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:/etc/abcde.conf:/etc/abcde/abcde.conf:g' abcde
	sed -i 's:/etc:/etc/abcde/:g' Makefile
}

src_install() {
	dodir /etc/abcde
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README TODO changelog
}
