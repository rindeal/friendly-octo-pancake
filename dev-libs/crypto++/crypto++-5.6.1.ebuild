# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.6.1.ebuild,v 1.5 2010/12/27 21:41:36 ranger Exp $

EAPI="3"

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix_build_system.patch" \
		"${FILESDIR}/${P}-sunos.patch"
}

src_compile() {
	# Higher optimizations cause problems.
	replace-flags -O? -O1
	filter-flags -fomit-frame-pointer
	use amd64 && append-flags -DCRYPTOPP_DISABLE_ASM

	emake -f GNUmakefile CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" \
		LIBDIR="$(get_libdir)" || die "emake failed"
}

src_test() {
	# Ensure that all test vectors have Unix line endings.
	local file
	for file in TestVectors/*; do
		edos2unix ${file}
	done

	if ! emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" test; then
		eerror "Crypto++ self-tests failed."
		eerror "Try to remove some optimization flags and reemerge Crypto++."
		die "emake test failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="$(get_libdir)" install \
		|| die "emake install failed"
}
