# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/addressable/addressable-2.2.2.ebuild,v 1.2 2010/12/27 20:15:34 grobian Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGEM_TASK_TEST="spec:normal"

RAKE_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README CHANGELOG"

inherit ruby-fakegem

DESCRIPTION="A replacement for the URI implementation that is part of Ruby's standard library."
HOMEPAGE="http://addressable.rubyforge.org/"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			ewarn "Tests disabled because they crash jruby."
			;;
		*)
			each_fakegem_test
			;;
	esac
}
