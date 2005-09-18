# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_umask/mod_umask-0.1.0.ebuild,v 1.3 2005/09/18 19:41:33 vericgar Exp $

inherit apache-module

DESCRIPTION="Sets the Unix umask of the Apache HTTPd process after it has started."
SRC_URI="http://www.apache.org/~pquerna/modules/${P}.tar.bz2"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_umask/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 x86"
IUSE=""

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="UMASK"

need_apache2

# vim:ts=4
