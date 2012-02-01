# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/idlastro/idlastro-20120120.ebuild,v 1.1 2012/02/01 17:45:40 bicatali Exp $

EAPI=4

DESCRIPTION="Astronomical user routines for IDL"
HOMEPAGE="http://idlastro.gsfc.nasa.gov/"
SRC_URI="${HOMEPAGE}/ftp/astron.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=">=dev-lang/gdl-0.9.2-r1"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/gnudatalanguage/${PN}
	doins -r pro/*
	dodoc *txt text/*
}
