# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnokii/gnokii-0.6.3.ebuild,v 1.1 2004/09/15 14:51:27 lanius Exp $

inherit eutils

IUSE="nls X bluetooth irda sms postgres mysql"

DESCRIPTION="a client that plugs into your handphone"
SRC_URI="http://www.gnokii.org/download/${P}.tar.bz2"
HOMEPAGE="http://www.gnokii.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND="X? ( =x11-libs/gtk+-1.2* )
	bluetooth? ( net-wireless/bluez-libs )
	irda? ( virtual/os-headers )
	sms? ( postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql ) )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-bindir.patch
	epatch ${FILESDIR}/${PN}-0.6.3-nounix98pty.patch.bz2
}

src_compile() {
	econf \
		`use_enable nls` \
		`use_with X x` \
	    --enable-security || die "configure failed"

	emake || die "make failed"

	if use sms
	then
		cd ${S}/smsd

		if use postgres; then
			emake libpq.la || die "smsd make failed"
		elif use mysql; then
			emake libmysql.la || die "smsd make failed"
		else
			emake libfile.la || die "smsd make failed"
		fi
	fi
}

src_install () {
	einstall || die "make install failed"

	dodoc Docs/*
	cp -r Docs/sample ${D}/usr/share/doc/${PF}/sample
	cp -r Docs/protocol ${D}/usr/share/doc/${PF}/protocol

	doman Docs/man/*

	insinto /etc
	doins ${S}/Docs/sample/gnokiirc

	# only one file needs suid root to make a psuedo device
	fperms 4755 ${D}/usr/sbin/mgnokiidev

	if [ `use sms` ]
	then
		cd ${S}/smsd

		einstall || die "smsd make install failed"
	fi

	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}

pkg_postinst() {
	einfo "gnokii does not need it's own group anymore."
	einfo "Make sure the user that runs gnokii has read/write access to the device"
	einfo "which your phone is connected to. eg. chown <user> /dev/ttyS0"
}
