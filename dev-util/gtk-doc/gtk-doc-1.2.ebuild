# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.2.ebuild,v 1.3 2004/05/30 23:37:04 leonardop Exp $

inherit elisp-common gnome2

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"
IUSE="emacs"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND=">=app-text/openjade-1.3.1
	=app-text/docbook-xml-dtd-4.1*
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	dev-libs/libxslt
	!app-text/xhtml1"

DOCS="AUTHORS ChangeLog COPYING MAINTAINERS NEWS README"

src_install() {
	gnome2_src_install

	docinto doc
	dodoc doc/*

	docinto examples
	dodoc examples/*

	if [ `use emacs` ]
	then
		elisp-compile tools/gtk-doc.el
		elisp-install ${PN} tools/gtk-doc.el*
	fi
}
