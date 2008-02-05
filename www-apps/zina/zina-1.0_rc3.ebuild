# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/zina/zina-1.0_rc3.ebuild,v 1.3 2008/02/05 14:09:06 hollow Exp $

inherit webapp depend.apache

MY_P=${P/_/}

DESCRIPTION="Zina (Zina Is Not Andromeda) is a digital audio streaming jukebox via a web interface."
HOMEPAGE="http://www.pancake.org/zina/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/httpd-php"

need_apache

S=${WORKDIR}/${MY_P}

src_install() {
	webapp_src_preinst

	touch "${S}"/zina.ini.php

	cp -R . "${D}"${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/zina.ini.php
	webapp_serverowned ${MY_HTDOCSDIR}/zina.ini.php

	keepdir ${MY_HTDOCSDIR}/_zina/cache
	webapp_serverowned ${MY_HTDOCSDIR}/_zina/cache

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
