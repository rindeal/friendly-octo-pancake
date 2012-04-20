# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/parrot/parrot-4.3.0.ebuild,v 1.1 2012/04/20 08:52:36 patrick Exp $

EAPI=3

# There's multiple small issues at the moment, so ...
RESTRICT="test"

inherit eutils multilib

DESCRIPTION="Virtual machine designed to efficiently compile and execute bytecode for dynamic languages"
HOMEPAGE="http://www.parrot.org/"
SRC_URI="ftp://ftp.parrot.org/pub/parrot/releases/stable/${PV}/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="opengl nls doc examples gdbm gmp ssl +unicode pcre"

RDEPEND="sys-libs/readline
	opengl? ( media-libs/freeglut )
	nls? ( sys-devel/gettext )
	unicode? ( >=dev-libs/icu-2.6 )
	gdbm? ( >=sys-libs/gdbm-1.8.3-r1 )
	gmp? ( >=dev-libs/gmp-4.1.4 )
	ssl? ( dev-libs/openssl )
	pcre? ( dev-libs/libpcre )"

DEPEND="dev-lang/perl[doc?]
	${RDEPEND}"

src_prepare() {
	# Fix for #404195 - pcre detection is wonky
	sed -i 's:libpcre.so.0:libpcre.so.1:' runtime/parrot/library/pcre.pir || die "Couldn't fix pcre location"
}

src_configure() {
	myconf="--disable-rpath"
	use unicode || myconf+=" --without-icu"
	use ssl     || myconf+=" --without-crypto"
	use gdbm    || myconf+=" --without-gdbm"
	use nls     || myconf+=" --without-gettext"
	use gmp     || myconf+=" --without-gmp"
	use opengl  || myconf+=" --without-opengl"
	use pcre    || myconf+=" --without-pcre"

	perl Configure.pl \
		--ccflags="${CFLAGS}" \
		--linkflags="${LDFLAGS}" \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--mandir="${EPREFIX}"/usr/share/man \
		--sysconfdir="${EPREFIX}"/etc \
		--sharedstatedir="${EPREFIX}"/var/lib/parrot \
		$myconf || die
}

src_compile() {
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"${S}"/blib/lib
	# occasionally dies in parallel make
	emake -j1 || die
	if use doc ; then
		emake -j1 html || die
	fi
}

src_test() {
	emake -j1 test || die
}

src_install() {
	emake -j1 install-dev DESTDIR="${D}" DOC_DIR="${EPREFIX}/usr/share/doc/${PF}" || die
	dodoc CREDITS DONORS.pod PBC_COMPAT PLATFORMS RESPONSIBLE_PARTIES TODO || die
	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins -r examples/* || die
	fi
	if use doc; then
		insinto "/usr/share/doc/${PF}/editor"
		doins -r editor || die
		cd docs/html
		dohtml -r developer.html DONORS.pod.html index.html ops.html parrotbug.html pdds.html \
			pmc.html tools.html docs src tools || die
	fi
}
