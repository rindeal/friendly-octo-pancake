# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhttpd-persistent/libhttpd-persistent-1.3p-r6.ebuild,v 1.6 2004/07/04 22:24:14 kugelfang Exp $

MY_P="libhttpd-1.3p-f"

DESCRIPTION="libhttpd-persistent is a modified version of David Hughes' libhttpd."
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND=""

S="${WORKDIR}/libhttpd-1.3-persistent-f"

src_compile() {
	econf || die

	# This is for versions since libhttpd-1.3p-e until the configure
	# process properly detects g++
	sed -i 's:gcc:g++:' Site.mm
	# end gcc to g++ edits.

	emake || die

	cd ${S}/src
	ranlib libhttpd-persistent.a || die

	for FILE in "protocol.c api.c version.c ip_acl.c select.c"; do
		g++ ${CFLAGS} -D_OS_UNIX -fPIC -c ${FILE}
	done
	g++ -shared -Wl,-shared,-soname,libhttpd-persistent.so -o libhttpd-persistent.so || die
}

src_install() {
	# This pacakge doesn't respect anything autoconf-ish
	dolib.a src/libhttpd-persistent.a
	dolib.so src/libhttpd-persistent.so

	mkdir -p ${D}/usr/include/
	cp src/httpd-persistent.h ${D}/usr/include/
	chmod 644 ${D}/usr/include/httpd-persistent.h

	dodoc HISTORY License README doc/FAQ.txt doc/libhttpd.pdf
}
