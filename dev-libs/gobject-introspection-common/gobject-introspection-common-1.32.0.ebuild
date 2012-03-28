# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gobject-introspection-common/gobject-introspection-common-1.32.0.ebuild,v 1.1 2012/03/28 00:58:04 tetromino Exp $

EAPI="4"
GNOME_ORG_MODULE="gobject-introspection"

inherit gnome.org

DESCRIPTION="Common files for development with GObject Introspection"
HOMEPAGE="http://live.gnome.org/GObjectIntrospection/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!<dev-libs/gobject-introspection-1.32.0"
# Before 1.32.0, ${PN} was part of gobject-introspection

src_configure() { :; }

src_compile() { :; }

src_install() {
	dodir /usr/share/aclocal
	insinto /usr/share/aclocal
	doins m4/introspection.m4

	dodir /usr/share/gobject-introspection-1.0
	insinto /usr/share/gobject-introspection-1.0
	doins Makefile.introspection
}
