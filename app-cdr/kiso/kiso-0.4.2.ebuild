# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kiso/kiso-0.4.2.ebuild,v 1.7 2005/01/01 12:16:37 eradicator Exp $

inherit kde
DEPEND="app-cdr/cdrtools
	app-admin/sudo"
RDEPEND="dev-libs/libcdio"
need-kde 3.2

RESTRICT="nomirror"
DESCRIPTION="KIso is a fronted for KDE to make it as easy as possible to create manipulate and extract CD Image files."
HOMEPAGE="http://kiso.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiso/KIso-${PV}b.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc"

SLOT="0"
IUSE=""


src_compile() {
	addwrite $QTDIR/etc/settings
	econf || die
	emake || die
}

src_install() {
	addwrite $QTDIR/etc/settings
	einstall || die
}

