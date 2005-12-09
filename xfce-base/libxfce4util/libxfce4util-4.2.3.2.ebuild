# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.2.3.2.ebuild,v 1.1 2005/12/09 21:00:47 dostrow Exp $

inherit xfce42

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="doc? ( dev-util/gtk-doc )"

XFCE_CONFIG="`use_enable doc gtk-doc`"
core_package