# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kworldclock/kworldclock-3.5.10.ebuild,v 1.5 2009/06/18 02:52:07 jer Exp $

KMNAME=kdetoys

# kworldclock is called kworldwatch in the tarball, doc/ is not
KMMODULE=kworldwatch
KMNODOCS=true
KMEXTRA="doc/kworldclock"

EAPI="1"
inherit kde-meta

DESCRIPTION="KDE program that displays the part of the Earth lit up by the Sun"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""
