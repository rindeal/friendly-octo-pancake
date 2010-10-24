# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-workbench/mysql-workbench-5.2.29-r1.ebuild,v 1.3 2010/10/24 09:55:05 graaff Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 eutils flag-o-matic autotools

MY_P="${PN}-gpl-${PV}-src"

DESCRIPTION="MySQL Workbench"
HOMEPAGE="http://dev.mysql.com/workbench/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug nls readline static-libs"

RDEPEND=">=x11-libs/gtk+-2.6
	dev-libs/glib:2
	gnome-base/libglade:2.0
	dev-libs/libsigc++:2
	dev-libs/boost
	>=dev-cpp/ctemplate-0.95
	>=dev-libs/libxml2-2.6.2
	>=dev-cpp/glibmm-2.14
	>=dev-cpp/gtkmm-2.14
	dev-libs/libzip
	>=virtual/mysql-5.1
	dev-libs/libpcre
	virtual/opengl
	>=dev-lang/lua-5.1[deprecated]
	gnome-base/libgnome
	x11-libs/pango
	|| ( sys-libs/e2fsprogs-libs
		dev-libs/ossp-uuid )
	>=x11-libs/cairo-1.5.12[svg]
	dev-python/pexpect
	dev-python/paramiko
	sys-apps/net-tools
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/"${MY_P}"

src_prepare() {
	# ifconfig isn't in the normal path
	sed -i -e 's:ifconfig:/sbin/ifconfig:' plugins/wb.admin/backend/wb_server_control.py || die

	epatch "${FILESDIR}/${PN}-5.2.17-python-libs.patch"
	eautoreconf

	# Remove bundled ctemplate version to make sure we use the system version.
	rm -rf ext/ctemplate || die
}

src_configure() {
	econf \
		$(use_enable nls i18n) \
		$(use_enable readline readline) \
		$(use_enable debug) \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${ED}" -name '*.la' -delete || die
}
