# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-7.0_alpha20051215.ebuild,v 1.1 2005/12/15 19:30:34 ciaranm Exp $

inherit vim

VIM_DATESTAMP="${PV##*alpha}"

VIM_VERSION="7.0aa"
VIM_SNAPSHOT="vim-${PV}.tar.bz2"
VIM_GENTOO_PATCHES="vim-7.0_alpha20051207-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="Vim, an improved vi-style text editor"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE=""
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	!minimal? ( ~app-editors/vim-core-${PV} )"
RDEPEND="${RDEPEND} !app-editors/nvi
	!minimal? ( ~app-editors/vim-core-${PV} )"
