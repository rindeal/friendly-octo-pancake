# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-0.9.3.ebuild,v 1.1 2007/04/21 23:58:57 pythonhead Exp $

NEED_PYTHON=2.2

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="An alternate test discovery and running process for unittest."
HOMEPAGE="http://somethingaboutorange.com/mrl/projects/nose/"
SRC_URI="http://somethingaboutorange.com/mrl/projects/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc examples"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/ez_setup/d' \
		setup.py || die "sed failed"
}

src_compile() {
	distutils_src_compile
	if use doc ; then
		PYTHONPATH=. scripts/mkindex.py
	fi
}

src_install() {
	DOCS="AUTHORS NEWS"
	distutils_src_install

	use doc && dohtml index.html

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "test failed"
}
