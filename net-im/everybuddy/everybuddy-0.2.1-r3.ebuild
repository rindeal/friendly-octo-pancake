# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Maintainer Bart Verwilst <verwilst@gentoo.org>, Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/everybuddy/everybuddy-0.2.1-r3.ebuild,v 1.1 2002/04/04 09:05:43 spider Exp $

S=${WORKDIR}/everybuddy-0.2.1beta6
DESCRIPTION="Universal Instant Messaging Client"
SRC_URI="http://www.everybuddy.com/files/everybuddy-0.2.1beta6.tar.gz"
HOMEPAGE="http://www.everybuddy.com/"
SLOT="0"
DEPEND="virtual/glibc 
		virtual/x11
		>=x11-libs/gtk+-1.2.10-r4
		arts? ( >=kde-base/arts-1.0.0 )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.4 )
		esd? ( >=media-sound/esound-0.2.24 )"

src_compile() {
    local myconf
	use arts || myconf="--disable-arts" && myconf="--enable-arts"
	use esd || myconf="${myconf} --disable-esd" && myconf="${myconf} --enable-esd"
	use gnome || myconf="${myconf} --without-gnome" && myconf="${myconf} --with-gnome"
	echo ${myconf} 
    ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die
    make || die

}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS NEWS README TODO COPYING ChangeLog

}


