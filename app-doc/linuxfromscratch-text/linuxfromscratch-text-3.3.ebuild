# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch-text/linuxfromscratch-text-3.3.ebuild,v 1.2 2002/04/27 04:52:49 seemant Exp $

MY_P="LFS-BOOK-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="The Linux From Scratch Book. Text Format"

SRC_URI="http://ftp.linuxfromscratch.org/lfs-books/${PV}/${MY_P}.txt.bz2
ftp://ftp.planetmirror.com/pub/lfs/lfs-books/${PV}/${MY_P}.txt.bz2
ftp://ftp.no.linuxfromscratch.org/mirrors/lfs/lfs-books/${PV}/${MY_P}.txt.bz2
http://ftp.nl.linuxfromscratch.org/linux/lfs/lfs-books/${PV}/${MY_P}.txt.bz2"

HOMEPAGE="http://www.linuxfromscratch.org"

src_unpack () {
	mkdir ${S} ; cd ${S}
	cp ${DISTDIR}/${A} .
	bunzip2 ${A} || die "bunzip2 failure"
}
src_install () {
	dodoc *
}
