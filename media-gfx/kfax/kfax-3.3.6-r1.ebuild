# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kfax/kfax-3.3.6-r1.ebuild,v 1.1 2010/11/13 23:20:24 dilfridge Exp $

EAPI=3

KDE_LINGUAS="af ar be bg br ca ca@valencia cs cy da de el en_GB eo es et eu fa
fi fr ga gl he hi hne hr hu is it ja km ko lt lv mai mk ms nb nds ne nl nn oc pa
pl pt pt_BR ro ru se sk sl sv ta tg th tr uk vi wa xh zh_CN zh_HK zh_TW"
KDE_DOC_DIRS="doc-translations/%lingua_${PN}"
inherit kde4-base

KDE_VERSION=4.4.0
MY_P=${P}-kde${KDE_VERSION}

DESCRIPTION="A fax file viewer"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-proto/xproto
"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}/${P}-kde45.patch" )
