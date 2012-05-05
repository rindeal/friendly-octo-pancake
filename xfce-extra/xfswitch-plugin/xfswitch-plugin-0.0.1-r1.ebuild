# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfswitch-plugin/xfswitch-plugin-0.0.1-r1.ebuild,v 1.3 2012/05/05 07:47:43 mgorny Exp $

EAPI=4
inherit multilib xfconf

DESCRIPTION="A panel plug-in for user switching (using x11-misc/lightdm or gnome-base/gdm)"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfswitch-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gdm"

COMMON_DEPEND=">=x11-libs/gtk+-2.12:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
RDEPEND="${COMMON_DEPEND}
	gdm? ( gnome-base/gdm )
	!gdm? ( x11-misc/lightdm )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		)

	DOCS=( AUTHORS ChangeLog NEWS README )
}

src_prepare() {
	if ! use gdm; then #411921
		sed -i \
			-e '/command/s:gdmflexiserver:/usr/libexec/lightdm/&:' \
			panel-plugin/main.c || die
	fi

	xfconf_src_prepare
}
