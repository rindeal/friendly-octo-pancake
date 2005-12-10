# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.4.3.ebuild,v 1.6 2005/12/10 07:17:51 chriswhite Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Monitor applets"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE="snmp"
DEPEND="snmp? ( net-analyzer/net-snmp )"

PATCHES="$FILESDIR/configure-fix-kdeutils-snmp.patch"
myconf="$myconf $(use_with snmp)"
