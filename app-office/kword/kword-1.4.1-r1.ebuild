# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-1.4.1-r1.ebuild,v 1.3 2005/10/11 14:54:10 carlo Exp $

KMNAME=koffice
MAXKOFFICEVER=${PV}
inherit kde-meta eutils

DESCRIPTION="KOffice word processor."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-koffice-1.4.1-rtfimport.diff"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange $PV $MAXKOFFICEVER app-office/kspread)
	>=app-text/wv2-0.1.8
	>=media-gfx/imagemagick-5.5.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoscript lib/koscript
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkspreadcommon kspread"

KMEXTRACTONLY="
	lib/
	kspread/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kword"

need-kde 3.3

src_unpack() {
	kde-meta_src_unpack unpack

	# Fix RTF import buffer overflow. Applied in 1.4.2.
	epatch "${DISTDIR}/post-koffice-1.4.1-rtfimport.diff"

	# We need to compile liboofilter first
	echo "SUBDIRS = liboofilter kword" > $S/filters/Makefile.am

	kde-meta_src_unpack makefiles
}
