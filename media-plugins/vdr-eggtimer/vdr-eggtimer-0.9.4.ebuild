# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-eggtimer/vdr-eggtimer-0.9.4.ebuild,v 1.1 2006/04/17 17:36:58 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Remind the user on various things (tee, cake, pizza) to be treated after some short time"
HOMEPAGE="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/#eggtimer"
SRC_URI="http://194.95.44.38/~pjuszack/digicam/download/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.37"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins
	doins ${S}/${VDRPLUGIN}.conf
}

