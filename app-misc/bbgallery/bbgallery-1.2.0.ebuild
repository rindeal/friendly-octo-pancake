# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbgallery/bbgallery-1.2.0.ebuild,v 1.1 2003/10/11 14:00:48 hillster Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Webpage image gallery creation perl script"
HOMEPAGE="http://bbgallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbgallery/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

RDEPEND="media-gfx/gimp
	 dev-lang/perl
	 media-gfx/imagemagick
	 dev-perl/URI
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser"

DEPEND="sys-apps/sed"

src_compile(){
	emake || die "compile failed"
}

src_install(){
	dobin bbgallery

	mv Contrib/JPG2jpg.pl Contrib/JPG2jpg
	dobin Contrib/JPG2jpg

	dodir /usr/lib/bbgallery
	exeinto /usr/lib/bbgallery
	doexe gimp_scale.pl

	dodoc CHANGELOG COPYING CREDITS README
	dohtml doc/*.html
}
