# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ptrace/python-ptrace-0.6.2.ebuild,v 1.2 2010/02/08 08:44:19 pva Exp $

EAPI="2"

NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes)."
HOMEPAGE="http://bitbucket.org/haypo/python-ptrace/ http://pypi.python.org/pypi/python-ptrace"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/distorm64"
RESTRICT_PYTHON_ABIS="2.4"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="ptrace"

src_prepare() {
	python_copy_sources --no-link

	conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return

		2to3-${PYTHON_ABI} -w . > /dev/null || die "2to3 failed"
		2to3-${PYTHON_ABI} -dw . > /dev/null || die "2to3 failed"
		epatch python3.0.patch
	}
	python_execute_function --action-message 'Applying patches for Python ${PYTHON_ABI}' --failure-message 'Applying patches for Python ${PYTHON_ABI} failed' -s conversion
}
