# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/cpyrit-opencl/cpyrit-opencl-0.4.0.ebuild,v 1.1 2012/03/29 16:43:19 maksbotan Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A sub-package that adds CUDA-capability to Pyrit"
HOMEPAGE="http://code.google.com/p/pyrit/"
SRC_URI="http://pyrit.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/openssl
	sys-libs/zlib
	virtual/opencl"
RDEPEND="${DEPEND}"
