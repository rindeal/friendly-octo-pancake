# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXcursor/libXcursor-1.1.11.ebuild,v 1.4 2010/12/23 11:56:17 ssuominen Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Xcursor library"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=x11-libs/libXrender-0.8.2
	x11-libs/libXfixes
	x11-libs/libX11
	x11-proto/fixesproto"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-icondir=/usr/share/cursors/xorg-x11
	--with-cursorpath=~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps"
