# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-foldoc/dictd-foldoc-2001.03.13-r1.ebuild,v 1.7 2004/02/22 18:22:06 agriffis Exp $

MY_P=foldoc-20010313
S=${WORKDIR}
DESCRIPTION="The Free On-line Dictionary of Computing for dict"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins foldoc.dict.dz
	doins foldoc.index
}

# vim: ai et sw=4 ts=4
