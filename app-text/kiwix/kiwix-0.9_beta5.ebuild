# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kiwix/kiwix-0.9_beta5.ebuild,v 1.2 2012/05/04 03:33:15 jdhore Exp $

EAPI=3

inherit multilib versionator

MY_P="${PN}-$(replace_version_separator 2 -)-src"

DESCRIPTION="A ZIM reader, especially for offline web content retrieved from Wikipedia"
HOMEPAGE="http://www.kiwix.org/"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# No upgrade from 0.9_alpha possible, because a directory would be replaced
# with a symlink, which PMS section 13.4 forbids. Bug #326685.
RDEPEND="app-arch/xz-utils
	=dev-cpp/clucene-0.9*
	dev-lang/perl
	dev-libs/icu
	dev-libs/xapian
	net-libs/libmicrohttpd
	=net-libs/xulrunner-1.9*
	>=net-misc/aria2-1.10
	!!<app-text/kiwix-0.9_beta"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGELOG README || die
}
