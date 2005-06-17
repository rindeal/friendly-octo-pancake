# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kst/kst-1.1.0.ebuild,v 1.1 2005/06/17 18:40:54 centic Exp $

inherit kde

DESCRIPTION="A plotting and data viewing program for KDE"
HOMEPAGE="http://omega.astro.utoronto.ca/kst/"
#SRC_URI="http://omega.astro.utoronto.ca/kst/${P}.tar.gz"
SRC_URI="http://mirrors.isc.org/pub/kde/stable/apps/KDE3.x/scientific/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.1 )"
RDEPEND="$DEPEND
	sci-libs/gsl"
need-kde 3.1

