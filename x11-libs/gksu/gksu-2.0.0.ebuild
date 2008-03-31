# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gksu/gksu-2.0.0.ebuild,v 1.21 2008/03/31 04:27:27 ricmm Exp $

inherit gnome2 fixheadtails

DESCRIPTION="A gtk+ frontend for libgksu"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc gnome"

RDEPEND=">=x11-libs/libgksu-2
	>=x11-libs/gtk+-2.4.0
	>=gnome-base/gconf-2.0
	gnome? ( >=gnome-base/nautilus-2 )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README"
G2CONF="$(use_enable doc gtk-doc) $(use_enable gnome nautilus-extension)"
USE_DESTDIR="1"

src_unpack() {
	gnome2_src_unpack
	ht_fix_file "${S}/gksu-migrate-conf.sh"
}

src_install() {
	gnome2_src_install
	chmod +x "${D}/usr/share/gksu/gksu-migrate-conf.sh"
}

pkg_postinst() {
	gnome2_pkg_postinst
	einfo 'updating configuration'
	"${ROOT}"/usr/share/gksu/gksu-migrate-conf.sh
	einfo ""
	einfo "A note on gksudo:  It actually runs sudo to get it's work done"
	einfo "However, by default, Gentoo's sudo wipes your envinronment."
	einfo "This means that gksudo will fail to run any X-based programs."
	einfo "You need to either add yourself to wheel and uncomment this line"
	einfo "in your /etc/sudoers:"
	einfo "Defaults:%wheel   !env_reset"
	einfo "Or remove the env_reset line entirely.  This can cause security"
	einfo "problems; if you don't trust your users, don't do this, use gksu"
	einfo "instead."
}
