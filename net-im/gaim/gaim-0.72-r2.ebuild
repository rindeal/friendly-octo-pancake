# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.72-r2.ebuild,v 1.4 2003/11/21 15:11:19 rizzo Exp $

IUSE="nls perl spell nas ssl cjk"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
EV=2.17
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2
	ssl? ( mirror://sourceforge/gaim-encryption/gaim-encryption-${EV}.tar.gz )"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="=sys-libs/db-1*
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	sys-devel/gettext
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.6.1
		>=sys-apps/sed-4.0.0 )
	( || ( dev-libs/nss
			( net-www/mozilla )
		)
	)
	spell? ( >=app-text/gtkspell-2.0.2 )"

src_unpack() {
	unpack ${A} || die
	epatch ${FILESDIR}/gaim-0.72-msn-fixes.patch

	use cjk && epatch ${FILESDIR}/gaim_cjk_gtkconv.patch

	use ssl && {
		cd ${S}/plugins
		unpack gaim-encryption-${EV}.tar.gz
	}
}

src_compile() {

	local myconf
	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"
	use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"

	if has_version "net-www/mozilla"; then
		NSS_LIB=/usr/lib/mozilla
		NSS_INC=/usr/lib/mozilla/include
	elif has_version "dev-libs/nspr"; then
		NSS_LIB=/usr/lib
		NSS_INC=/usr/include
	else
		# Not sure how this would happen with our current DEPEND setup
		eerror "Neither net-www/mozilla nor dev-libs/nspr found."
		die "Unexpected error. Unable to find nss/nspr"
	fi

	myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
	myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
	myconf="${myconf} --with-nspr-libs=${NSS_LIB}"
	myconf="${myconf} --with-nss-libs=${NSS_LIB}"

	econf ${myconf} || die "Configuration failed"
	use perl && sed -i -e 's:^\(PERL_MM_PARAMS =.*PREFIX=\)\(.*\):\1'${D}'\2:' plugins/perl/Makefile
	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"

	use ssl && {
		local myencconf
		cd ${S}/plugins/gaim-encryption-${EV}

		myencconf="${myencconf} --with-nspr-includes=${NSS_INC}/nspr"
		myencconf="${myencconf} --with-nss-includes=${NSS_INC}/nss"
		myencconf="${myencconf} --with-nspr-libs=${NSS_LIB}"
		myencconf="${myencconf} --with-nss-libs=${NSS_LIB}"
		econf ${myencconf} || die "Configuration failed for encryption"
		emake || die "Make failed for encryption"
	}
}

src_install() {
	einstall || die "Install failed"
	use ssl && {
		cd ${S}/plugins/gaim-encryption-${EV}
		einstall || die "Install failed for encryption"
		cd ${S}
	}
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION
}

pkg_postinst() {
	if [ `use cjk` ]; then
		ewarn
		ewarn "You have chosen (by selecting 'USE=cjk') to compile with"
		ewarn "a patch for CJK support.  Please be aware that this patch"
		ewarn "causes problems with skkinput.  kinput2 works fine.  Details"
		ewarn "can be found at http://bugs.gentoo.org/show_bug.cgi?id=24657#c23"
		ewarn
	fi

	if [ `use ssl` ]; then
		ewarn
		ewarn "You have chosen (by selecting 'USE=ssl') to install"
		ewarn "the gaim-encryption plugin ( http://gaim-encryption.sf.net/ )"
		ewarn "this plugin is NOT supported by the Gaim project, and if you"
		ewarn "expierence problems related to it, contact the Gentoo project"
		ewarn "via http://bugs.gentoo.org/ or the gaim-encryption project."
	fi
}
