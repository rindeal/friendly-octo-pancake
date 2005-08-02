# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-xdict-en-zh-gb/stardict-xdict-en-zh-gb-2.4.2.ebuild,v 1.6 2005/08/02 20:30:23 gustavoz Exp $

FROM_LANG="English"
TO_LANG="Simplified Chinese (GB)"
DICT_PREFIX="xdict-ec-"
DICT_SUFFIX="gb"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_GB.php"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
