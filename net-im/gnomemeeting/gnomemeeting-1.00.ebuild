# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-1.00.ebuild,v 1.13 2005/02/06 22:53:39 stkn Exp $

inherit eutils gnome2

DESCRIPTION="H.323 compatible Gnome VoIP/videoconferencing client"
HOMEPAGE="http://www.gnomemeeting.org"
# now part of gnome-2.4
SRC_URI="http://www.gnomemeeting.org/includes/clicks_counter.php?http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc amd64 ppc"
IUSE="ipv6 sdl ssl"

RDEPEND="~dev-libs/pwlib-1.6.3
	~net-libs/openh323-1.13.2
	>=net-nds/openldap-2.0.25
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libgnome-2.0
	>=net-libs/linc-0.5.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.6.1
	>=media-sound/esound-0.2.28
	>=gnome-base/orbit-2.5.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	dev-lang/perl
	app-text/scrollkeeper"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
	# closes #80232
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {

	local myconf

	myconf="${myconf} --with-ptlib-includes=/usr/include/ptlib"
	myconf="${myconf} --with-ptlib-libs=/usr/lib"
	myconf="${myconf} --with-openh323-includes=/usr/include/openh323"
	myconf="${myconf} --with-openh323-libs=/usr/lib"

	if use ssl; then
		myconf="${myconf} --with-openssl-libs=/usr/lib"
		myconf="${myconf} --with-openssl-includes=/usr/include/openssl"
	fi

	use sdl \
		&& myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

	econf \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} || die "configure failed"
	emake || die
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
