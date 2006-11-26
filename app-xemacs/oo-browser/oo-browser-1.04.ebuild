# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/oo-browser/oo-browser-1.04.ebuild,v 1.1 2006/11/26 08:24:49 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Multi-Language Object-Oriented Code Browser."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/hyperbole
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

