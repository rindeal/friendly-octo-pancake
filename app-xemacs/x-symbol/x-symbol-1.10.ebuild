# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/x-symbol/x-symbol-1.10.ebuild,v 1.2 2007/06/03 19:42:38 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Semi WYSIWYG for LaTeX, HTML, etc, using additional fonts."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/auctex
app-xemacs/mail-lib
"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages

