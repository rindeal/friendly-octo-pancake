# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-NTLM/Authen-NTLM-1.90.0.ebuild,v 1.2 2012/02/24 09:55:00 ago Exp $

EAPI=4

MY_PN=NTLM
MODULE_AUTHOR=NBEBOUT
MODULE_VERSION=1.09
inherit perl-module

DESCRIPTION="An NTLM authentication module"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=virtual/perl-MIME-Base64-3.00
	dev-perl/Digest-HMAC"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)"

SRC_TEST=do
export OPTIMIZE="$CFLAGS"
