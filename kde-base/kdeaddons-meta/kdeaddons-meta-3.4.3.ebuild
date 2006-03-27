# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-meta/kdeaddons-meta-3.4.3.ebuild,v 1.9 2006/03/27 15:29:32 agriffis Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="arts"

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/atlantikdesigner)
$(deprange $PV $MAXKDEVER kde-base/knewsticker-scripts)
$(deprange 3.4.1 $MAXKDEVER kde-base/ksig)
$(deprange 3.4.2 $MAXKDEVER kde-base/vimpart)
$(deprange $PV $MAXKDEVER kde-base/kaddressbook-plugins)
$(deprange $PV $MAXKDEVER kde-base/kate-plugins)
$(deprange $PV $MAXKDEVER kde-base/kicker-applets)
$(deprange 3.4.1 $MAXKDEVER kde-base/kdeaddons-kfile-plugins)
$(deprange $PV $MAXKDEVER kde-base/konq-plugins)
$(deprange $PV $MAXKDEVER kde-base/konqueror-akregator)
$(deprange 3.4.1 $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)
$(deprange 3.4.1 $MAXKDEVER kde-base/renamedlg-audio)
$(deprange 3.4.1 $MAXKDEVER kde-base/renamedlg-images)
arts? ( $(deprange $PV $MAXKDEVER kde-base/noatun-plugins) )
"

