# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvdshrink/dvdshrink-2.6.1_p8.ebuild,v 1.2 2006/12/17 23:19:17 kugelfang Exp $

inherit eutils

DESCRIPTION="Scriptable DVD copy software"
HOMEPAGE="http://dvdshrink.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_p/-}mdk.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="X"

KEYWORDS="~amd64 ~x86 ~ppc"
S="${WORKDIR}/${PN}"


RDEPEND=">=media-video/transcode-1.0.2-r2
	>=media-video/mjpegtools-1.8.0-r1
	>=media-video/subtitleripper-0.3.4-r1
	>=media-video/dvdauthor-0.6.11
	>=app-cdr/dvd+rw-tools-6.1
	X? ( >=dev-perl/gtk2-perl-1.104 )
	>=app-text/gocr-0.40
	virtual/cdrtools"

pkg_setup() {
	if ! built_with_use media-video/transcode dvdread; then
		einfo "Please re-emerge transcode with the dvdread USE flag."
		die  "transcode needs dvdread support builtin."
	fi
}

src_install() {

	dobin ./usr/bin/dvdshrink || die "Install of dvdshrink failed"
	if use X ; then
		dobin ./usr/bin/xdvdshrink.pl || die "Install of xdvdshrink.pl failed"
	fi

	dobin ./usr/bin/dvdsfunctions || die "Install of dvdsfunctions failed"
	dobin ./usr/bin/batchrip.sh || die "Install of batchrip.sh failed"

	insinto /usr/share/dvdshrink
	doins usr/share/applications/dvdshrink/xdvdshrink_logo.png

	insinto /usr/share/dvdshrink/menus
	doins usr/share/applications/dvdshrink/menus/*.mpg

	insinto /usr/share/dvdshrink/32x32
	doins usr/share/applications/dvdshrink/32x32/dvdsrhink.xpm

	insinto /usr/share/dvdshrink/64x64
	doins usr/share/applications/dvdshrink/64x64/dvdshrink.xpm

	dodoc usr/share/doc/dvdshrink/{INSTALL,README.txt,batchrip.txt,example.xml,gpl.txt}

	insinto /usr/share/icons/dvdshrink
	doins usr/share/icons/{batchrip.xpm,dvdshrink.xpm}
}
