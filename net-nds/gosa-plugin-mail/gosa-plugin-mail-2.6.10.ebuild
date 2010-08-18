# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/gosa-plugin-mail/gosa-plugin-mail-2.6.10.ebuild,v 1.1 2010/08/18 15:07:10 dev-zero Exp $

EAPI=3

DESCRIPTION="GOsa plugin for Mail integration"
HOMEPAGE="https://oss.gonicus.de/labs/gosa/wiki/WikiStart."
SRC_URI="ftp://oss.gonicus.de/pub/gosa/${P}.tar.bz2
	http://oss.gonicus.de/pub/gosa/${P}.tar.bz2
	ftp://oss.gonicus.de/pub/gosa/archive/${P}.tar.bz2
	http://oss.gonicus.de/pub/gosa/archive/${P}.tar.bz2	"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="~net-nds/gosa-core-${PV}
	~net-nds/gosa-plugin-systems-${PV}"

GOSA_COMPONENT="${PN/gosa-plugin-}"

src_install() {
	insinto /etc/gosa
	doins -r etc/*

	insinto /usr/share/gosa/html/plugins/${GOSA_COMPONENT}/
	doins -r html/*

	insinto /usr/share/gosa/locale/plugins/${GOSA_COMPONENT}/
	doins -r locale/*

	insinto /usr/share/gosa/plugins
	doins -r addons admin personal

	insinto /usr/share/gosa/doc/plugins/${GOSA_COMPONENT}/
	doins help/guide.xml

	dodoc contrib/*
	insinto /usr/share/doc/${PF}
	doins -r contrib/sieve_vacation
}

pkg_postinst() {
	ebegin "Updating class cache and locales"
	"${EROOT}"usr/sbin/update-gosa
	eend $?
}
