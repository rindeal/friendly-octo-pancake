# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-da/myspell-da-20060316.ebuild,v 1.13 2009/03/30 14:32:02 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"da,DK,da_DK,Danish (Denmark),da_DK.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"da,DK,hyph_da_DK,Danish (Denmark),hyph_da_DK.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Danish dictionaries for myspell/hunspell"
LICENSE="GPL-2 LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://da.speling.org/"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
