# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eclectic/eclectic-0.9.2.ebuild,v 1.4 2005/05/12 18:27:28 kugelfang Exp $

inherit bash-completion

DESCRIPTION="Modular -config replacement utility"
HOMEPAGE="http://developer.berlios.de/projects/eclectic/"
SRC_URI="http://download.berlios.de/eclectic/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc"

RDEPEND="app-shells/bash
	doc? ( dev-python/docutils )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README doc/*.txt
	use doc && dohtml doc/*
	dobashcompletion misc/eclectic.bashcomp
}
