# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-0.9.9.ebuild,v 1.3 2001/08/05 20:21:53 csjoly Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast, lightweight imageviewer using imlib2"
SRC_URI="http://www.linuxbrit.co.uk/downloads/feh-0.9.9.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"

DEPEND="media-libs/imlib2"

src_compile() {

	try ./configure  --host=${CHOST} --with-imlib2=/usr/X11R6/
    try emake

}

src_install () {

    try make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog README TODO
}

 
