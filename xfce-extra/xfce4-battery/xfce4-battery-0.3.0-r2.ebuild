# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.3.0-r2.ebuild,v 1.11 2007/03/02 22:41:08 drac Exp $

inherit xfce42 eutils

DESCRIPTION="Xfce4 panel battery monitor plugin"
KEYWORDS="amd64 arm ~hppa ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND=">=xfce-base/xfce4-panel-3.99.2"

goodies_plugin

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ac_adapter.patch
}
