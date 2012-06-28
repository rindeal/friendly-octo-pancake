# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/anyjson/anyjson-0.3.3.ebuild,v 1.1 2012/06/28 05:55:21 patrick Exp $

EAPI="4"

PYTHON_DEPEND="2 3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Wraps the best available JSON implementation available in a common interface."
HOMEPAGE="http://bitbucket.org/runeh/anyjson"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"
