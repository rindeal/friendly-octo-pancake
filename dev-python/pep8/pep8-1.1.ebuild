# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pep8/pep8-1.1.ebuild,v 1.1 2012/05/29 18:33:10 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"

inherit distutils vcs-snapshot

DESCRIPTION="Python style guide checker"
HOMEPAGE="http://github.com/jcrocholl/pep8 http://pypi.python.org/pypi/pep8"
SRC_URI="https://github.com/jcrocholl/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

PYTHON_MODNAME=${PN}.py
DOCS="CHANGES.txt"

src_test() {
	test_func() {
		test_ok=0
		PYTHONPATH="${S}" ${PYTHON} "${S}/${PYTHON_MODNAME}" -v	--testsuite=testsuite || test_ok=1
		PYTHONPATH="${S}" ${PYTHON} "${S}/${PYTHON_MODNAME}" --doctest -v || test_ok=1
		return ${test_ok}
	}
	python_execute_function test_func
}
