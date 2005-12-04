# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-3.5.0.ebuild,v 1.3 2005/12/04 10:50:21 kloeri Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="library common to many KDE games"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""
DEPEND=""

# For now, make sure things aren't installed GUID root (which you apparently can get with some combination of configure parameters).
# The question about the games group owning this is apparently still open?
myconf="$myconf --disable-setgid"
