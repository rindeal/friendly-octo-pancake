# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-plugins/gkrellm-plugins-1.2.11-r1.ebuild,v 1.9 2004/06/24 22:56:59 agriffis Exp $

IUSE="gnome"

S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="emerge this package to install all of the gkrellm plugins"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
		x11-plugins/gkrellm-bfm
		x11-plugins/gkrellm-console
		x11-plugins/gkrellm-mailwatch
		x11-plugins/gkrellm-radio
		x11-plugins/gkrellm-reminder
		x11-plugins/gkrellm-volume
		x11-plugins/gkrellmitime
		x11-plugins/gkrellmlaunch
		x11-plugins/gkrellmms
		x11-plugins/gkrellmoon
		x11-plugins/gkrellmouse
		x11-plugins/gkrellmwho
		x11-plugins/gkrellmwireless
		x11-plugins/gkrellshoot
		x11-plugins/gkrellweather
		gnome? ( x11-plugins/gkrellm-gnome )"
