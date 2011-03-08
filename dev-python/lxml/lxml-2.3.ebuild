# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lxml/lxml-2.3.ebuild,v 1.2 2011/03/08 14:52:08 jer Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

MY_P="${PN}-${PV/_/}"

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/ http://pypi.python.org/pypi/lxml"
SRC_URI="http://codespeak.net/lxml/${MY_P}.tgz"
# SRC_URI="http://codespeak.net/lxml/dev/${MY_P}.tgz"

LICENSE="BSD ElementTree GPL-2 PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc examples +threads"

RDEPEND=">=dev-libs/libxml2-2.7.2
	>=dev-libs/libxslt-1.1.15
	>=dev-python/beautifulsoup-3.0.8"
DEPEND="${RDEPEND}
	dev-python/setuptools"
# lxml tarball contains files pregenerated by Cython.

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

# Compiler warnings are suppressed without --warnings option.
DISTUTILS_GLOBAL_OPTIONS=("--warnings")

src_compile() {
	distutils_src_compile $(use threads || echo --without-threading)
}

src_test() {
	testing() {
		# Tests broken with Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		local module
		for module in lxml/etree lxml/objectify; do
			ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}.so" "src/${module}.so" || die "ln -fs src/${module} failed"
		done

		local exit_status="0" test
		for test in test.py selftest.py selftest2.py; do
			einfo "Running ${test}"
			if ! PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" "${test}"; then
				eerror "${test} failed with $(python_get_implementation) $(python_get_version)"
				exit_status="1"
			fi
		done

		return "${exit_status}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/* || die "Installation of documentation failed"
		dodoc *.txt || die "Installation of documentation failed"
		docinto doc
		dodoc doc/*.txt || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die "Installation of examples failed"
	fi
}
