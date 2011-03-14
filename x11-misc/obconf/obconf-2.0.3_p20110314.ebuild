# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-2.0.3_p20110314.ebuild,v 1.4 2011/03/14 16:53:44 hwoarang Exp $

EAPI=2
inherit autotools fdo-mime

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://icculus.org/openbox/index.php/ObConf:About"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.5.0_pre20110313"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}

src_prepare() {
	eautopoint
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGELOG README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
