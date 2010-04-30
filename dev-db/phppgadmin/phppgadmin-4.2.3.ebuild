# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-4.2.3.ebuild,v 1.1 2010/04/30 22:01:38 mabi Exp $

EAPI="2"
inherit webapp depend.php

IUSE=""

MY_P=phpPgAdmin-${PV}

DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	dev-lang/php[postgres,session]
"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	local doc
	local docs="CREDITS DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS"
	dodoc ${docs}
	mv conf/config.inc.php-dist conf/config.inc.php

	cp -r * "${D}"${MY_HTDOCSDIR}
	for doc in ${docs} INSTALL LICENSE; do
		rm -f "${D}"${MY_HTDOCSDIR}/${doc}
	done

	webapp_configfile ${MY_HTDOCSDIR}/conf/config.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
