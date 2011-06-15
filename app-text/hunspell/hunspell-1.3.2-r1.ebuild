# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hunspell/hunspell-1.3.2-r1.ebuild,v 1.2 2011/06/15 19:30:09 pva Exp $

EAPI="4"
inherit eutils multilib autotools flag-o-matic versionator

MY_P=${PN}-${PV/_beta/b}

DESCRIPTION="Hunspell spell checker - an improved replacement for myspell in OOo."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://hunspell.sourceforge.net/"

SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="ncurses nls readline static-libs"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

DEPEND="readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	sys-devel/gettext"
RDEPEND="${DEPEND}"

#TODO: "ia" "mi" - check what they are and add appropriate desc...
def="app-dicts/myspell-en"
for l in \
"af" "bg" "ca" "cs" "cy" "da" "de" "el" "en" "eo" "es" "et" "fo" "fr" "ga" \
"gl" "he" "hr" "hu" "id" "it" "ku" "lt" "lv" "mk" "ms" "nb" "nl" \
"nn" "pl" "pt" "ro" "ru" "sk" "sl" "sv" "sw" "tn" "uk" "zu" \
; do
	dep="linguas_${l}? ( app-dicts/myspell-${l/pt_BR/pt-br} )"
	[[ ${l} = "de" ]] &&
		dep="linguas_de? ( || ( app-dicts/myspell-de app-dicts/myspell-de-alt ) )"
	[[ -z ${PDEPEND} ]] &&
		PDEPEND="${dep}" ||
		PDEPEND="${PDEPEND}
${dep}"
	def="!linguas_${l}? ( ${def} )"
	IUSE="${IUSE} linguas_${l}"
done
PDEPEND="${PDEPEND}
${def}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Upstream package creates some executables which names are too generic
	# to be placed in /usr/bin - this patch prefixes them with 'hunspell-'.
	# It modifies a Makefile.am file, hence eautoreconf.
	epatch "${FILESDIR}"/${PN}-1.3-renameexes.patch
	eautoreconf
}

src_configure() {
	# missing somehow, and I am too lazy to fix it properly
	[[ ${CHOST} == *-darwin* ]] && append-libs -liconv

	# I wanted to put the include files in /usr/include/hunspell
	# but this means the openoffice build won't find them.
	econf \
		$(use_enable nls) \
		$(use_with ncurses ui) \
		$(use_with readline readline) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	#342449
	pushd "${ED}"/usr/$(get_libdir)/ >/dev/null
	ln -s lib${PN}{-$(get_major_version).$(get_version_component_range 2).so.0.0.0,.so}
	popd >/dev/null

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO license.hunspell
	# hunspell is derived from myspell
	dodoc AUTHORS.myspell README.myspell license.myspell
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	elog "To use this package you will also need a dictionary."
	elog "Hunspell uses myspell format dictionaries; find them"
	elog "in the app-dicts category as myspell-<LANG>."
}
