# Copyright 2002 Gentoo Technologies Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-CD-disc-cover/Audio-CD-disc-cover-0.04.ebuild,v 1.7 2002/10/04 05:18:56 vapier Exp $

inherit perl-module

MY_P=Audio-CD-0.04-disc-cover-1.1.0
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl Module needed for app-cdr/disc-cover"
HOMEPAGE="http://home.wanadoo.nl/~jano/disc-cover.html"
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/libraries/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND}
	>=dev-perl/MIME-Base64-2.12
	>=dev-perl/URI-1.10
	>=dev-perl/HTML-Parser-3.15
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/libnet-1.0703-r1
	>=dev-perl/libwww-perl-5.50
	>=media-libs/libcdaudio-0.99.6"  

RDEPEND="${DEPEND}"
