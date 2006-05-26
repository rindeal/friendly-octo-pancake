# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/eyesapplet/eyesapplet-3.5.2.ebuild,v 1.4 2006/05/26 15:21:31 wolf31o2 Exp $

KMNAME=kdetoys
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kicker applet: eyes following the movement of the mouse pointer"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""
DEPEND=""