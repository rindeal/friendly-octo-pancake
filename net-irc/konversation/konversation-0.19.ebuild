# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.19.ebuild,v 1.3 2006/02/05 17:25:04 flameeyes Exp $

LANGS="bg cs da de el en_GB es et fi fr hi it ja nl pt pt_BR ru sr sr@Latn sv ta tr"
LANGS_DOC="da es et it nl pt sv"

USE_KEG_PACKAGING=1

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3

PATCHES="${FILESDIR}/${P}-gcc41.patch"
