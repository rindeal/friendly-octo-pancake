# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-ingo/horde-ingo-1.2.5.ebuild,v 1.3 2012/02/08 19:26:30 jer Exp $

HORDE_PHP_FEATURES="imap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="e-mail filter rules manager for Horde IMP"

KEYWORDS="~alpha amd64 hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND="|| ( >=www-apps/horde-3 >=www-apps/horde-groupware-1 )"
