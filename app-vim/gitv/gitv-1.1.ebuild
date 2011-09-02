# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gitv/gitv-1.1.ebuild,v 1.1 2011/09/02 09:58:17 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.2"

inherit vim-plugin

DESCRIPTION="vim plugin: gitk for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3574"
SRC_URI="https://github.com/vim-scripts/${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="gitv"

RDEPEND="dev-vcs/git
	app-vim/fugitive"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	rm -f README
}

src_install() {
	dodoc ${P}/README.markdown
	rm -rf ${P}
	vim-plugin_src_install
}
