# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite3/sqlite3-1.3.6.ebuild,v 1.5 2012/09/28 11:54:56 johu Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs faq"
RUBY_FAKEGEM_DOCDIR="doc faq"
RUBY_FAKEGEM_EXTRADOC="API_CHANGES.rdoc README.rdoc ChangeLog.cvs CHANGELOG.rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="An extension library to access a SQLite database from Ruby"
HOMEPAGE="http://rubyforge.org/projects/sqlite-ruby/"
LICENSE="BSD"

KEYWORDS="amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND+=" =dev-db/sqlite-3*"
DEPEND+=" =dev-db/sqlite-3*"

ruby_add_bdepend "
	dev-ruby/rake-compiler
	dev-ruby/hoe
	test? ( virtual/ruby-test-unit )
	doc? ( dev-ruby/redcloth )"

all_ruby_prepare() {
	# We remove the vendor_sqlite3 rake task because it's used to
	# bundle SQlite3 which we definitely don't want.
	rm tasks/vendor_sqlite3.rake || die

	sed -i -e 's:, HOE.spec::' -e '/task :test/d' tasks/native.rake || die
}

each_ruby_configure() {
	${RUBY} -Cext/sqlite3 extconf.rb || die
}

each_ruby_compile() {
	# TODO: not sure what happens with jruby

	emake -Cext/sqlite3
	mv ext/sqlite3/sqlite3_native$(get_modname) lib/sqlite3/ || die
}

each_ruby_install() {
	each_fakegem_install

	# sqlite3 was called sqlite3-ruby before, so add a spec file that
	# simply loads sqlite3 to make sure that old projects load correctly
	# we don't even need to create a file to load this: the `require
	# sqlite3` was already part of sqlite3-ruby requirements.
	cat - <<EOF > "${T}/sqlite3-ruby.gemspec"
# generated by ebuild
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sqlite3/sqlite3-1.3.6.ebuild,v 1.5 2012/09/28 11:54:56 johu Exp $
Gem::Specification.new do |s|
  s.name = "sqlite3-ruby"
  s.version = "${RUBY_FAKEGEM_VERSION}"
  s.summary = "Fake gem to load sqlite3"
  s.homepage = "${HOMEPAGE}"
  s.specification_version = 3
  s.add_runtime_dependency("${RUBY_FAKEGEM_NAME}", ["= ${RUBY_FAKEGEM_VERSION}"])
end
EOF
	RUBY_FAKEGEM_NAME=sqlite3-ruby \
		RUBY_FAKEGEM_GEMSPEC="${T}/sqlite3-ruby.gemspec" \
		ruby_fakegem_install_gemspec
}
