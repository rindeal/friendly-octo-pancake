# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/knowit/knowit-0.8.ebuild,v 1.2 2003/09/05 22:43:30 msterret Exp $

inherit kde-base
need-kde 3

DESCRIPTION="KnowIt is a simple tool for managing notes - similar to TuxCards but KDE based."
SRC_URI="http://knowit.sourceforge.net/files/${P}.tar.bz2"
HOMEPAGE="http://knowit.sourceforge.net"

# Note: mirrored sourceforge copies of this file don't seem to exist, so
# the above SRC_URI cannot (as of the writing of this ebuild) use 
# mirror:

LICENSE="GPL-2"
KEYWORDS="x86"
