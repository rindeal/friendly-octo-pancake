# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta  <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/mini-howto-ps/mini-howto-ps-20010824.ebuild,v 1.2 2002/04/27 04:58:38 seemant Exp $

MY_P="Linux-mini-ps-HOWTOs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The LDP mini-howtos, ps format."

SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

src_install () {
    
    dodir /usr/share/doc/howto/mini
    dodir /usr/share/doc/howto/mini/ps
    dosym /usr/share/doc/howto /usr/share/doc/HOWTO
    
    cd ${WORKDIR}
    insinto /usr/share/doc/howto/mini/ps
    doins *
    
}
