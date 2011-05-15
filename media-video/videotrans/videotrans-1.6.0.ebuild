# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/videotrans/videotrans-1.6.0.ebuild,v 1.3 2011/05/15 15:43:09 scarabeus Exp $

EAPI=4

inherit base eutils

DESCRIPTION="A package to convert movies to DVD format and to build DVDs with."
HOMEPAGE="http://videotrans.sourceforge.net/"
SRC_URI="mirror://sourceforge/videotrans/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND="virtual/ffmpeg
	media-video/mplayer
	media-video/mjpegtools[png]
	media-video/dvdauthor
	media-gfx/imagemagick"

RDEPEND="${DEPEND}
	www-client/lynx
	app-shells/bash
	sys-devel/bc"

PATCHES=( "${FILESDIR}/${P}-forced-as-needed.patch" )

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES THANKS TODO aspects.txt
}
