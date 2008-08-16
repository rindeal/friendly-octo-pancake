# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mailbox/vdr-mailbox-0.6.0.ebuild,v 1.1 2008/08/16 07:55:39 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: MailBox"
HOMEPAGE="http://alex.vdr-developer.org"
SRC_URI="http://alex.vdr-developer.org/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.8
		>=net-libs/c-client-2002e-r1"

