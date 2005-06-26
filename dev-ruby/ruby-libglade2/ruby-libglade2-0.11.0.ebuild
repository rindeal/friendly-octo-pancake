# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.11.0.ebuild,v 1.3 2005/06/26 15:42:01 usata Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="~alpha x86 ~ia64 ~ppc ~sparc"
IUSE="gnome"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=gnome-base/libglade-2"
RDEPEND="${DEPEND}
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )
	!gnome? ( >=dev-ruby/ruby-gtk2-${PV} )"
