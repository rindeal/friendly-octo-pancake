# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.2.ebuild,v 1.6 2004/05/31 18:45:21 vapier Exp $

inherit gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86 ppc ~sparc ~alpha hppa ~amd64 ~ia64"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/ORBit2-2.3.94"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

# Check out >=gnome-speech-0.3.2-r1 for java support
export JAVAC=no
