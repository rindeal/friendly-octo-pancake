# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phprojekt/phprojekt-4.2-r2.ebuild,v 1.1 2004/12/29 13:01:25 stuart Exp $

inherit webapp

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
IUSE="postgres mysql"
SRC_URI="mirror://gentoo/${P}.tar.gz http://phprojekt.com/files/4.2/setup.zip http://phprojekt.com/files/4.2/lib.zip"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="net-www/apache
		postgres? ( dev-db/postgresql )
		mysql? ( dev-db/mysql )
		virtual/php"

src_unpack () {
	unpack ${A}

	# patch for security flaw - see bug #73021
	cp ${WORKDIR}/setup.php ${S}

	# patch for security flaw - see bug #75858
	cp ${WORKDIR}/authform.inc.php ${S}/lib/
	cp ${WORKDIR}/gpcs_vars.inc.php ${S}/lib/
}

pkg_setup () {
	webapp_pkg_setup
	einfo "Please make sure that your PHP is compiled with support for IMAP and your database of choice"
}

src_install() {
	webapp_src_preinst

	dodoc ChangeLog install readme
	rm -f ChangeLog install readme
	cp -R . ${D}/${MY_HTDOCSDIR}
	for file in chat attach upload; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
