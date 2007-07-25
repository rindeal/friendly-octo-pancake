# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aylet/aylet-0.5.ebuild,v 1.2 2007/07/25 14:27:42 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Aylet plays music files in the .ay format."
HOMEPAGE="http://rus.members.beeb.net/aylet.html"
SRC_URI="http://ftp.ibiblio.org/pub/Linux/apps/sound/players/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="gtk"

RDEPEND="sys-libs/ncurses
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DDRIVER_OSS" \
		${PN} || die "emake failed."
	use gtk && emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DDRIVER_OSS" gtk2 || die "emake failed."
}

src_install() {
	dobin ${PN}
	use gtk && dobin x${PN}
	local mansuffix=$(ecompress --suffix)
	doman ${PN}.1
	use gtk && dosym aylet.1${mansuffix} /usr/share/man/man1/xaylet.1${mansuffix}
	dodoc ChangeLog NEWS README TODO
}
