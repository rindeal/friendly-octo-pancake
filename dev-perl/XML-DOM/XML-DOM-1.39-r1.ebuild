# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.39-r1.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
	dev-perl/XML-RegExp"
