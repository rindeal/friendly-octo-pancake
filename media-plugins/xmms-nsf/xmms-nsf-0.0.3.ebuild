# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nsf/xmms-nsf-0.0.3.ebuild,v 1.4 2003/08/07 04:01:45 vapier Exp $

DESCRIPTION="An xmms input-plugin for NSF-files (the nintendo 8-bit soundfiles) that uses source from NEZamp."
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://optronic.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
