# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.4.0_beta1.ebuild,v 1.2 2005/01/17 19:23:43 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86"
IUSE="crypt gnokii pda sasl"

DEPEND="~kde-base/kdebase-${PV}
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( net-dialup/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	!net-www/akregator
	!app-pda/kitchensync"

src_compile() {
	# needed to detect pi-notepad.h, used by the kpilot notepad conduit.
	use pda && myconf="${myconf} --with-extra-includes=/usr/include/libpisock"

	kde_src_compile
}
