# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.6.ebuild,v 1.9 2003/02/15 08:02:01 gerk Exp $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}
LICENSE="GPL-2"
SRC_URI="http://www.geocities.com/bilibao/${P}-rc.tar.gz"
HOMEPAGE="http://www.geocities.com/bilibao/kssh.html"
DESCRIPTION="KDE 3.x frontend for SSH"
KEYWORDS="x86 sparc  ~ppc"

newdepend ">=net-misc/openssh-3.1_p1"

