# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-syck/ruby-syck-0.35.ebuild,v 1.1 2003/07/09 11:37:35 twp Exp $

MY_P=syck-${PV}
DESCRIPTION="An extension for reading YAML swiftly in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/syck/"
SRC_URI="mirror://sourceforge/yaml4r/${MY_P}.tar.gz"
LICENSE="BSD D&R"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
DEPEND="dev-lang/ruby =dev-libs/syck-${PV}"
S=${WORKDIR}/${MY_P}

src_compile() {
	cd ext/ruby
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	cd ext/ruby
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
}
