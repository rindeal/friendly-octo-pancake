# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/podsleuth/podsleuth-0.6.7.ebuild,v 1.5 2011/03/12 11:56:50 angelos Exp $

EAPI=2
inherit mono

DESCRIPTION="A tool to discover detailed model information about an Apple (TM) iPod (TM)."
HOMEPAGE="http://download.banshee.fm/podsleuth/"
SRC_URI="http://download.banshee.fm/${PN}/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-dotnet/ndesk-dbus-glib
	>=dev-lang/mono-2
	sys-apps/hal
	>=sys-apps/sg3_utils-1.27"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--with-hal-callouts-dir=/usr/libexec
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	mono_multilib_comply
}
