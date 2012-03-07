# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-sqlplus/oracle-instantclient-sqlplus-11.2.0.3.ebuild,v 1.1 2012/03/07 14:13:14 haubi Exp $

EAPI="4"

inherit eutils

MY_PLAT_x86="Linux x86"
MY_A_x86="${PN#oracle-}-linux-${PV}.0.zip"

MY_PLAT_amd64="Linux x86-64"
MY_A_amd64="${PN#oracle-}-linux.x64-${PV}.0.zip"

DESCRIPTION="Oracle 11g Instant Client: SQL*Plus"
HOMEPAGE="http://www.oracle.com/technetwork/database/features/instant-client/index.html"
SRC_URI="
	x86?   ( ${MY_A_x86}   )
	amd64? ( ${MY_A_amd64} )
"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="~dev-db/oracle-instantclient-basic-${PV}"

S="${WORKDIR}"/instantclient_11_2

my_arch() {
	# platform name
	MY_PLAT=MY_PLAT_${ARCH}
	export MY_PLAT=${!MY_PLAT}
	# distfile
	MY_A=MY_A_${ARCH}
	export MY_A=${!MY_A}
}

pkg_nofetch() {
	my_arch
	eerror "Please go to"
	eerror "  ${HOMEPAGE%/*}/index-097480.html"
	eerror "  and download"
	eerror "Instant Client for ${MY_PLAT}"
	eerror "    SQL*Plus: ${MY_A}"
	eerror "After downloading, put it in:"
	eerror "  ${DISTDIR}/"
}

src_install() {
	# all binaries go here
	local oracle_home=/usr/$(get_libdir)/oracle/${PV}/client
	into "${oracle_home}"

	dolib.so libsqlplus$(get_libname) libsqlplusic$(get_libname)
	dobin sqlplus

	insinto "${oracle_home}"/sqlplus/admin
	doins glogin.sql

	dosym "${oracle_home}"/bin/sqlplus /usr/bin/sqlplus
}
