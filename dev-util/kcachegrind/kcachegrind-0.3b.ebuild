# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kcachegrind/kcachegrind-0.3b.ebuild,v 1.5 2004/05/25 23:57:27 caleb Exp $
inherit kde

need-kde 3

IUSE=""
DESCRIPTION="A kde frontend for the cachegrind profiling tool, which is part of valgrind"
SRC_URI="mirror://sourceforge/kcachegrind/${P}.tar.gz"
HOMEPAGE="http://kcachegrind.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=dev-util/calltree-0.9.1
	media-gfx/graphviz"
