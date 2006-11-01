# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/docker/docker-1.5.ebuild,v 1.10 2006/11/01 01:20:28 omp Exp $

DESCRIPTION="Openbox app which acts as a system tray for KDE and GNOME2"
HOMEPAGE="http://icculus.org/openbox/2/docker/"
SRC_URI="http://icculus.org/openbox/2/${PN}/${P}.tar.gz"

RDEPEND=">=dev-libs/glib-2.0.4
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

src_install() {
	dobin docker
	dodoc README
}
