# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbeam/kbeam-0.61.ebuild,v 1.1 2004/10/30 16:50:50 carlo Exp $

inherit kde
need-kde 3.2

KLV="14683"
DESCRIPTION="A KDE application that lets you send and receive files to devices, using your Infrared port."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=${KLV}"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"

DEPEND=">=dev-libs/openobex-1.0.0"
