# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-oxford-en-zh-gb/stardict-oxford-en-zh-gb-2.4.2.ebuild,v 1.4 2004/06/29 22:10:50 agriffis Exp $

FROM_LANG="English"
TO_LANG="Simplified Chinese (GB)"
DICT_PREFIX="oxford-"
DICT_SUFFIX="gb"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_CN.php"

KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
