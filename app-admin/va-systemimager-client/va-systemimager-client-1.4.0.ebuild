# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-client/va-systemimager-client-1.4.0.ebuild,v 1.11 2002/12/09 04:17:36 manson Exp $

DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="mirror://sourceforge/systemimager/${P}.tar.bz2"
HOMEPAGE="http://systemimager.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_install() {
	DESTDIR=${D} ./installclient --quiet || die
}
