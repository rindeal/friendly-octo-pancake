# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.3.0.ebuild,v 1.3 2004/08/30 15:45:01 pvdabeel Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="~x86 ~amd64 ~sparc ppc"
IUSE=""

src_unpack() {
	kde_src_unpack
	# Fix for SPARC compilation issues, may also work for PPC, PPC64
	use sparc && epatch ${FILESDIR}/${P}-sparc.patch
}
