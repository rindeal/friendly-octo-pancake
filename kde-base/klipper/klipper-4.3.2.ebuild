# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klipper/klipper-4.3.2.ebuild,v 1.1 2009/10/06 19:39:16 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libtaskmanager-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"
