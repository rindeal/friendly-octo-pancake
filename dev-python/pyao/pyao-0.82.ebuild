# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyao/pyao-0.82.ebuild,v 1.5 2004/07/06 07:59:15 eradicator Exp $

inherit distutils

DESCRIPTION="Python bindings for the libao library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc -amd64 -sparc"

DEPEND="virtual/python
	>=media-libs/libao-0.8.3"

src_compile() {
	./config_unix.py || die
	distutils_src_compile
}

