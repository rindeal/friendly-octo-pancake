# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hpricot/hpricot-0.5.ebuild,v 1.2 2007/03/13 19:03:20 tgall Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A fast and liberal HTML parser for Ruby."
HOMEPAGE="http://code.whytheluckystiff.net/hpricot/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/ruby-1.8.4"
