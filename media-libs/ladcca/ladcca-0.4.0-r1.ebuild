# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladcca/ladcca-0.4.0-r1.ebuild,v 1.2 2007/02/03 23:17:19 beandog Exp $

inherit eutils

IUSE=""

DESCRIPTION="Linux Audio Developer's Configuration and Connection API (LADCCA)"
HOMEPAGE="http://pkl.net/~node/ladcca.html"
SRC_URI="http://pkl.net/~node/ladcca.html/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	>=x11-libs/gtk+-2.0"

src_unpack() {
	unpack ${P}.tar.gz || die
	epatch ${FILESDIR}/${P}-*.patch
}

src_compile() {
	econf --disable-serv-inst || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# Add to /etc/services
	if ! grep -q ^ladcca /etc/services; then
		dodir /etc
		insinto /etc
		doins /etc/services
		echo -e "\nladcca\t\t14541/tcp\t\t\t# LADCCA client/server protocol" >> ${D}/etc/services
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
}
