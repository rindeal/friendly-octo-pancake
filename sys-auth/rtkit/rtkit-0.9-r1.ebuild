# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/rtkit/rtkit-0.9-r1.ebuild,v 1.7 2011/03/30 17:19:51 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Realtime Policy and Watchdog Daemon"
HOMEPAGE="http://0pointer.de/blog/projects/rtkit"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="GPL-3 BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/dbus
	sys-auth/polkit
	sys-libs/libcap"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup rtkit
	enewuser rtkit -1 -1 -1 "rtkit"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install"

	./rtkit-daemon --introspect > org.freedesktop.RealtimeKit1.xml
	insinto /usr/share/dbus-1/interfaces
	doins org.freedesktop.RealtimeKit1.xml
}

pkg_postinst () {
	einfo "To start using RealtimeKit, you need to ensure that the 'dbus'"
	einfo "service is running. If it is already running, you need to reload it"
	einfo "with the following command:"
	einfo ""
	einfo "    /etc/init.d/dbus reload"
}
