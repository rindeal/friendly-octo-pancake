# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.9.ebuild,v 1.2 2003/11/16 18:39:04 brad_mssw Exp $

inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc amd64"

RDEPEND=">=sys-devel/gdb-5.0"
