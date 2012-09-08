# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/openrc-settingsd/openrc-settingsd-1.0.1.ebuild,v 1.1 2012/09/08 00:10:52 tetromino Exp $

EAPI=4

DESCRIPTION="System settings D-Bus service for OpenRC"
HOMEPAGE="http://gnome.gentoo.org/openrc-settingsd.xml"
SRC_URI="http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

COMMON_DEPEND=">=dev-libs/glib-2.30:2
	dev-libs/libdaemon
	sys-apps/dbus
	sys-apps/openrc
	sys-auth/polkit"
RDEPEND="${COMMON_DEPEND}
	sys-auth/nss-myhostname
	systemd? ( sys-apps/systemd )
	!systemd? ( !sys-apps/systemd )"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	dev-util/gdbus-codegen
	virtual/pkgconfig"

src_configure() {
	econf \
		--with-pidfile="${EPREFIX}"/var/run/openrc-settingsd.pid
}

src_install() {
	default
	if use systemd; then
		# Avoid file collision with systemd
		rm -vr "${ED}"usr/share/{dbus-1,polkit-1} "${ED}"etc/dbus-1 || die "rm failed"
	fi
}

pkg_postinst() {
	if use systemd; then
		elog "You installed ${PN} with USE=systemd. In this mode,"
		elog "${PN} will not start via simple dbus activation, so you"
		elog "will have to manually enable it as an rc service:"
		elog " # /etc/init.d/openrc-settingsd start"
		elog " # rc-update add openrc-settingsd default"
	fi
}
