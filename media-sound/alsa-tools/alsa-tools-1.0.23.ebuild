# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-1.0.23.ebuild,v 1.2 2010/05/23 19:04:50 armin76 Exp $

inherit eutils flag-o-matic autotools

MY_P="${P/_rc/rc}"

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
SRC_URI="mirror://alsaproject/tools/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~amd64 ~mips ~sparc ~x86"

ECHOAUDIO_CARDS="alsa_cards_darla20 alsa_cards_gina20
alsa_cards_layla20 alsa_cards_darla24 alsa_cards_gina24
alsa_cards_layla24 alsa_cards_mona alsa_cards_mia alsa_cards_indigo
alsa_cards_indigoio alsa_cards_echo3g"

IUSE="fltk gtk alsa_cards_hdsp alsa_cards_hdspm alsa_cards_mixart
alsa_cards_vx222 alsa_cards_usb-usx2y alsa_cards_sb16 alsa_cards_sbawe
alsa_cards_emu10k1 alsa_cards_emu10k1x alsa_cards_ice1712
alsa_cards_rme32 alsa_cards_rme96 alsa_cards_sscape alsa_cards_pcxhr
${ECHOAUDIO_CARDS}"

RDEPEND=">=media-libs/alsa-lib-1.0.22
	>=dev-python/pyalsa-1.0.22
	fltk? ( =x11-libs/fltk-1.1* )
	gtk? ( =x11-libs/gtk+-2* )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {

	ALSA_TOOLS="ac3dec seq/sbiload us428control hwmixvolume"

	if use gtk; then
		use alsa_cards_ice1712 && \
			ALSA_TOOLS="${ALSA_TOOLS} envy24control"
		use alsa_cards_rme32 && use alsa_cards_rme96 && \
			ALSA_TOOLS="${ALSA_TOOLS} rmedigicontrol"
	fi

	if use alsa_cards_hdsp || use alsa_cards_hdspm; then
		ALSA_TOOLS="${ALSA_TOOLS} hdsploader"
		use fltk && ALSA_TOOLS="${ALSA_TOOLS} hdspconf hdspmixer"
	fi

	use alsa_cards_mixart && ALSA_TOOLS="${ALSA_TOOLS} mixartloader"
	use alsa_cards_vx222 && ALSA_TOOLS="${ALSA_TOOLS} vxloader"
	use alsa_cards_usb-usx2y && ALSA_TOOLS="${ALSA_TOOLS} usx2yloader"
	use alsa_cards_pcxhr && ALSA_TOOLS="${ALSA_TOOLS} pcxhr"
	use alsa_cards_sscape && ALSA_TOOLS="${ALSA_TOOLS} sscape_ctl"

	{ use alsa_cards_sb16 || use alsa_cards_sbawe; } && \
		ALSA_TOOLS="${ALSA_TOOLS} sb16_csp"

	if use alsa_cards_emu10k1 || use alsa_cards_emu10k1x; then
		ALSA_TOOLS="${ALSA_TOOLS} as10k1 ld10k1"
	fi

	if use gtk; then
		for card in ${ECHOAUDIO_CARDS}; do
			if use ${card}; then
				ALSA_TOOLS="${ALSA_TOOLS} echomixer"
			fi
		done
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug 273129
	epatch "${FILESDIR}"/envy24control-config-dir.patch

	# This block only deals with the tools that still use GTK and the
	# AM_PATH_GTK macro.
	for dir in echomixer envy24control rmedigicontrol; do
		has "${dir}" "${ALSA_TOOLS}" || continue
		pushd "${dir}" &> /dev/null
		sed -i -e '/AM_PATH_GTK/d' configure.in
		eautoreconf
		popd &> /dev/null
	done

	# This block deals with the tools that are being patched
	for dir in hdspconf; do
		has "${dir}" "${ALSA_TOOLS}" || continue
		pushd "${dir}" &> /dev/null
		eautoreconf
		popd &> /dev/null
	done

	elibtoolize
}

src_compile() {
	if use fltk; then
		# hdspmixer requires fltk
		append-ldflags "-L/usr/$(get_libdir)/fltk-1.1"
		append-flags "-I/usr/include/fltk-1.1"
	fi

	local f
	for f in ${ALSA_TOOLS}
	do
		cd "${S}/${f}"
		econf --with-gtk2 || die "econf ${f} failed"
		emake || die "emake ${f} failed"
	done
}

src_install() {
	local f
	for f in ${ALSA_TOOLS}
	do
		# Install the main stuff
		cd "${S}/${f}"
		emake DESTDIR="${D}" install || die

		# Install the text documentation
		local doc
		for doc in README TODO ChangeLog AUTHORS; do
			if [[ -f "${doc}" ]]; then
				mv "${doc}" "${doc}.$(basename ${f})" || die
				dodoc "${doc}.$(basename ${f})" || die
			fi
		done
	done
}
