# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.4.ebuild,v 1.10 2004/11/13 02:34:51 kumba Exp $

inherit ruby

MY_P=${P}-all
DESCRIPTION="A LALR(1) parser generator for Ruby"
HOMEPAGE="http://www.loveruby.net/en/racc.html"
SRC_URI="http://www.loveruby.net/archive/racc/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86 ppc"
USE_RUBY="ruby16 ruby18 ruby19"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND="|| ( >=dev-lang/ruby-1.8
		( =dev-lang/ruby-1.6*
		>=dev-ruby/amstd-1.9.5
		>=dev-ruby/strscan-0.6.5 )
		dev-lang/ruby-cvs
	)"
