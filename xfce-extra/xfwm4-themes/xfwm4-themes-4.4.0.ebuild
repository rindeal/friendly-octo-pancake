# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfwm4-themes/xfwm4-themes-4.4.0.ebuild,v 1.8 2007/03/09 17:51:39 jer Exp $

inherit xfce44

xfce44

DESCRIPTION="Window manager themes"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"
RESTRICT="binchecks strip"

RDEPEND=">=xfce-base/xfwm4-${XFCE_MASTER_VERSION}"
DEPEND=""

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package
