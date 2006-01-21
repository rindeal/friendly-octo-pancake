# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl/bioperl-1.4.ebuild,v 1.11 2006/01/21 17:32:30 ribosome Exp $

inherit perl-app eutils

DESCRIPTION="Collection of tools for bioinformatics, genomics and life science research"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://www.${PN}.org/ftp/DIST/${P}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ~sparc x86"
IUSE="mysql gd"

DEPEND="perl-core/File-Temp
	dev-perl/HTML-Parser
	dev-perl/IO-String
	dev-perl/IO-stringy
	dev-perl/SOAP-Lite
	perl-core/Storable
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-Writer
	dev-perl/XML-Twig
	dev-perl/libxml-perl
	dev-perl/libwww-perl
	dev-perl/Graph
	dev-perl/Text-Shellwords
	gd? (
			>=dev-perl/GD-1.32-r1
			dev-perl/SVG
			dev-perl/GD-SVG
		)
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
	         PREFIX="${D}"/usr INSTALLDIRS=vendor
}

src_test() {
	perl-module_src_test || die "Test failed"
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
