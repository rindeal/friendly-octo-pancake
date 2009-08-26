# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-0.6.15.ebuild,v 1.1 2009/08/26 23:16:11 a3li Exp $

inherit gems

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND="=dev-ruby/httparty-0.4.3
	>=dev-ruby/oauth-0.3.5
	=dev-ruby/mash-0.0.3"
RDEPEND="${DEPEND}"
