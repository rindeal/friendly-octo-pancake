# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.2.ebuild,v 1.2 2004/01/15 13:23:49 sergey Exp $

if [ $( use kde ) ]; then
	inherit kde-base eutils
	need-kde 3
else
	inherit base kde-functions eutils
	need-qt 3
fi

LICENSE="GPL-2"
DESCRIPTION="An ICQ v8 Client. Supports File Transfer, Chat, Server-Side Contactlist, ..."
SRC_URI="mirror://sourceforge/sim-icq/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://sim-icq.sourceforge.net"
KEYWORDS="~x86 ~ppc -amd64"
SLOT="0"
IUSE="ssl kde"

newdepend "ssl? ( dev-libs/openssl )"
DEPEND="$DEPEND
	sys-devel/flex
	sys-devel/automake
	sys-devel/autoconf
	app-text/sablotron"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-head.patch
	epatch ${FILESDIR}/${P}-configure.in.patch

	sed -i 's:rm -rf $(sim_plugindir)/.*::g' plugins/*/Makefile.in
}

src_compile() {
	local myconf

	myconf="$( use_enable ssl openssl )"
	myconf="$myconf $( use_enable kde )"
	myconf="$myconf --without-gkrellm_plugin"
	myconf="$myconf --prefix=/usr"

	if [ $( use kde ) ]; then
		need-kde 3
	else
		need-qt 3
	fi

	WANT_AUTOMAKE=1.7

	autoconf

	use kde && kde_src_compile myconf

	econf $myconf --without-gkrellm || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc TODO README ChangeLog COPYING AUTHORS
}
