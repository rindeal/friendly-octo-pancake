# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdoc/kdoc-3.0.ebuild,v 1.1 2002/04/03 18:14:07 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Documentation tools"

newdepend "sys-devel/perl"

