# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Daemon/Proc-Daemon-0.140.0.ebuild,v 1.3 2012/02/06 19:26:18 ranger Exp $

EAPI=4

MODULE_AUTHOR=DETI
MODULE_SECTION=Proc
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Perl Proc-Daemon -  Run Perl program as a daemon process"

SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
