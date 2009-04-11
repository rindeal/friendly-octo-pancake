# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-4.2.2.ebuild,v 1.1 2009/04/11 22:16:58 alexxy Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug pam"

DEPEND="
	pam? (
		>=kde-base/kdebase-pam-7
		virtual/pam
	)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/kdebase-4.0.2-pam-optional.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with pam PAM)"

	kde4-meta_src_configure
}
