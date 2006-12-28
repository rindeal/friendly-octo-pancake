# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systray/xfce4-systray-4.2.3.ebuild,v 1.13 2006/12/28 05:06:33 nichoj Exp $

inherit xfce42

DESCRIPTION="Xfce 4 system tray"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND=">=xfce-base/xfce4-panel-${PV}
	>=xfce-base/libxfcegui4-4.2.0"

core_package
