# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/svninfo/svninfo-0.7.4.ebuild,v 1.1 2010/10/24 14:46:30 aballier Exp $

inherit latex-package eutils

LICENSE="LPPL-1.2"
DESCRIPTION="A LaTeX module to access SVN version info"
HOMEPAGE="http://www.brucker.ch/projects/svninfo/index.en.html"
SRC_URI="http://www.brucker.ch/projects/svninfo/download/${P}.tar.gz"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

DOCS="README"

TEXMF=/usr/share/texmf-site

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.5-latex-compile.patch"
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	emake -j1 || die "compilation failed"
}
