# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-rails/eselect-rails-0.18.ebuild,v 1.1 2011/12/30 09:21:52 graaff Exp $

DESCRIPTION="Manages Ruby on Rails symlinks"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~flameeyes/ruby-team/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.0"

src_install() {
	insinto /usr/share/eselect/modules
	doins *.eselect || die "doins failed"
}
