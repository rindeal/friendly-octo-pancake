# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id: gplflash-0.4.10.ebuild,v 1.7 2002/10/04 06:19:32 vapier Exp $

S=${WORKDIR}/flash-0.4.10
DESCRIPTION="GPL Shockwave Flash Player/Plugin"
SRC_URI="http://www.swift-tools.com/Flash/flash-0.4.10.tgz"
HOMEPAGE="http://www.swift-tools.com/Flash"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="media-libs/libflash"

PATCH=${FILESDIR}/gentoo.diff

src_unpack() {
	cd ${WORKDIR}
	unpack flash-0.4.10.tgz
	cd ${S}
	cat ${PATCH} | patch -p0 || die
}

src_compile() {
	cd ${S}
	emake
}

src_install() {                               
  cd ${S}/Plugin
  insinto /opt/netscape/plugins
  doins npflash.so
  cd ${S}
  dodoc README ReadMe.htm
  
  if [ "`use mozilla`" ] ; then
    dodir /usr/lib/mozilla/plugins
    dosym /opt/netscape/plugins/npflash.so \
          /usr/lib/mozilla/plugins/npflash.so 
  fi
}
