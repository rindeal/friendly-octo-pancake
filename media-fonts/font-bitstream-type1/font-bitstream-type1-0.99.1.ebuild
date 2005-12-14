# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bitstream-type1/font-bitstream-type1-0.99.1.ebuild,v 1.3 2005/12/14 18:18:12 cardoe Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
