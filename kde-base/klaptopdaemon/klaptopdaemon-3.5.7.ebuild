# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.7.ebuild,v 1.6 2007/08/08 15:12:48 armin76 Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-02.tar.bz2"

DESCRIPTION="KLaptopdaemon - KDE battery monitoring and management for laptops."
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

RDEPEND="x11-libs/libXtst"

DEPEND="${RDEPEND}
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libX11
	x11-proto/xproto
	virtual/os-headers"

PATCHES="${FILESDIR}/${P}-libXss-linking.patch"
EPATCH_EXCLUDE="klaptopdaemon-3.5-suspend2+xsession-errors.diff"

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"

	kde_src_compile
}
