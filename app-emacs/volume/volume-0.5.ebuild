# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/volume/volume-0.5.ebuild,v 1.3 2008/06/23 07:14:14 ulm Exp $

inherit elisp

DESCRIPTION="Tweak your sound card volume from Emacs"
HOMEPAGE="http://www.brockman.se/software/volume-el/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

# NOTE we might define the following which volume.el can work with by
# default, but volume.el can really work with anything.

# RDEPEND="|| ( media-sound/aumixer media-sound/alsa-utils )"

SITEFILE=50${PN}-gentoo.el
