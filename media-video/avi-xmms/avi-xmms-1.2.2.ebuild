# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/avi-xmms/avi-xmms-1.2.2.ebuild,v 1.4 2001/05/10 01:52:55 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A xmms plugin for AVI/DivX movies"
SRC_URI="http://www.xmms.org/files/plugins/avi-xmms/avi-xmms-1.2.2.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND=">=media-video/avifile-0.53.5 media-sound/xmms"

src_compile() {
    cd ${S}
    local myprefix
    if [ "`use gnome`" ]
    then
      myprefix="/opt/gnome"
	else
      myprefix="/usr/X11R6"
    fi
    echo $myprefix > ${T}/myprefix
	try ./configure --prefix=$myprefix --host=${CHOST}
}

src_install () {
    cd ${S}
    try make libdir=`cat ${T}/myprefix`/lib/xmms/Input DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README TODO
}

