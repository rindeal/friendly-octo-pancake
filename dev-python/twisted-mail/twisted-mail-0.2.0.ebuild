# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-mail/twisted-mail-0.2.0.ebuild,v 1.2 2006/01/31 23:24:28 agriffis Exp $

MY_PACKAGE=Mail

inherit twisted

DESCRIPTION="A Twisted Mail library, server and client."

KEYWORDS="~alpha ~ia64 ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.1
	dev-python/twisted-names"
