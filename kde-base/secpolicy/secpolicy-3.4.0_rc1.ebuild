# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/secpolicy/secpolicy-3.4.0_rc1.ebuild,v 1.2 2005/03/13 02:20:51 cryos Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Display PAM security policies"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

# NOTE TODO some dep is missing here - check on empty install