# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ksplash-ml/ksplash-ml-0.95.2.ebuild,v 1.10 2003/09/05 23:29:05 msterret Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/ksplashml-${PV}
DESCRIPTION="Fancy splash-screen for KDE 3.x"
SRC_URI="http://www.shadowcom.net/Software/ksplash-ml/ksplashml-${PV}.tgz"
HOMEPAGE="http://www.shadowcom.net/Software/ksplash-ml"

newdepend ">=kde-base/kdebase-3.0"

LICENSE="BSD"

KEYWORDS="x86 ppc"
