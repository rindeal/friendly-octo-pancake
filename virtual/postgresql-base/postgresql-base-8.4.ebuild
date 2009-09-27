# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/postgresql-base/postgresql-base-8.4.ebuild,v 1.2 2009/09/27 14:55:35 ranger Exp $

EAPI="1"

DESCRIPTION="Virtual for PostgreSQL base (clients + libraries)"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( =dev-db/libpq-${PV}* dev-db/postgresql-base:${SLOT} )"
