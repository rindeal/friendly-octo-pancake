# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-esp/ghostscript-esp-8.15.3.ebuild,v 1.6 2006/10/15 13:09:00 dertobi123 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools elisp-common eutils versionator

DESCRIPTION="ESP Ghostscript -- an enhanced version of GPL Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/espgs"

MY_P=espgs-${PV}
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
		http://ftp.rz.tu-bs.de/pub/mirror/ftp.easysw.com/ftp/pub/ghostscript/${PV}/espgs-${PV}-source.tar.bz2
		ftp://ftp3.easysw.com/pub/ghostscript/${PV}/espgs-${PV}-source.tar.bz2"
ESVN_REPO_URI="http://svn.easysw.com/public/espgs/trunk"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X cups cjk emacs gtk threads xml"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	xml? ( >=dev-libs/libxml2-2.6.8 )
	media-libs/fontconfig
	!app-text/ghostscript-gnu
	!app-text/ghostscript-gpl"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A/adobe-cmaps-200406.tar.gz acro5-cmaps-2001.tar.gz}
	if use cjk; then
		cat ${FILESDIR}/ghostscript-esp-8.15.2-cidfmap.cjk >> ${S}/lib/cidfmap
		cat ${FILESDIR}/ghostscript-esp-8.15.2-FAPIcidfmap.cjk >> ${S}/lib/FAPIcidfmap
		cd ${S}/Resource
		unpack adobe-cmaps-200406.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi
	cd ${S}

	# http://cups.org/espgs/str.php?L2000
	epatch ${FILESDIR}/ghostscript-esp-8.15.1-fPIC.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		src/Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		src/Makefile.in || die "sed failed"
	sed -i -e "s:exdir=.*:exdir=/usr/share/doc/${PF}/examples:" \
		src/Makefile.in || die "sed failed"
	sed -i -e "s:docdir=.*:docdir=/usr/share/doc/${PF}/html:" \
		-e "s:GS_DOCDIR=.*:GS_DOCDIR=/usr/share/doc/${PF}/html:" \
		src/Makefile.in src/*.mak || die "sed failed"

	ln -s src/configure.ac .
	ln -s src/Makefile.in .
	cp /usr/share/automake-1.9/install-sh "${S}"
	AT_NOELIBTOOLIZE="yes" eautoreconf
	cd ijs
	AT_NOELIBTOOLIZE="yes" eautoreconf
	elibtoolize
}

src_compile() {
	econf $(use_with X x) \
		$(use_enable gtk) \
		$(use_enable cups) \
		$(use_enable threads) \
		$(use_with xml omni) \
		--with-fontconfig \
		--with-ijs \
		--with-jbig2dec || die "econf failed"
	emake -j1 so all || die "emake failed"

	cd ijs
	econf || die "ijs econf failed"
	emake || die "ijs emake failed"
}

src_install() {
	emake install_prefix="${D}" install soinstall || die "emake install failed"

	rm -fr ${D}/usr/share/doc/${PF}/html/{README,PUBLIC}
	dodoc doc/README
	use emacs && elisp-site-file-install doc/gsdoc.el

	cd ${S}/ijs
	emake DESTDIR="${D}" install || die "emake ijs install failed"
}

pkg_postinst() {
	ewarn "If you are upgrading from ghostscript-7 you need to rebuild"
	ewarn "gimp-print. Please run 'revdep-rebuild' to do this."
}
