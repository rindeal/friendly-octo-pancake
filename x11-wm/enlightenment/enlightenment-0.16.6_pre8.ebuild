# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.6_pre8.ebuild,v 1.2 2003/10/12 04:19:11 vapier Exp $

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P/_/-}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls esd gnome kde"

DEPEND=">=media-libs/fnlib-0.5
	esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-1*
	>=gnome-base/libghttp-1.0.9-r1
	>=media-libs/imlib-1.9.8"
RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/_pre?/}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable esd sound` \
		--enable-upgrade \
		--enable-hints-ewmh \
		`use_enable gnome hints-gnome` \
		`use_enable kde hints-kde` \
		--enable-fsstd \
		--enable-zoom \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/enlightenment

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README

	# fix default xcursor support
	cd ${D}/usr/share/enlightenment/themes
	local deftheme=`readlink DEFAULT`
	cp -rf ${deftheme} ${deftheme}-xcursors
	rm DEFAULT
	ln -s ${deftheme}-xcursors DEFAULT
	rm -rf ${deftheme}-xcursors/cursors*
	cp ${FILESDIR}/cursors.cfg ${deftheme}-xcursors/
}
