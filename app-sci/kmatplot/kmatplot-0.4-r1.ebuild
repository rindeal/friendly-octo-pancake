# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kmatplot/kmatplot-0.4-r1.ebuild,v 1.8 2004/07/13 20:37:56 agriffis Exp $

PATCHES="${FILESDIR}/${P}-gentoo.patch
	${FILESDIR}/${P}-inline.patch
	${FILESDIR}/${P}-gentoo2.patch
	${FILESDIR}/${P}-kmatplotrc.patch"

inherit kde

DESCRIPTION="gnuplot-like tool for plotting data sets in either two or three dimensions"
HOMEPAGE="http://kmatplot.sourceforge.net/"
SRC_URI="http://kmatplot.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

need-kde 3
