# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nullmailer/nullmailer-1.00_rc7-r2.ebuild,v 1.2 2004/06/24 22:24:15 agriffis Exp $

inherit eutils

MY_P="${P/_rc/RC}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple relay-only local mail transport agent"
SRC_URI="http://untroubled.org/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://untroubled.org/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
		sys-apps/groff"
RDEPEND="!virtual/mta
		virtual/glibc
		>=sys-apps/supervise-scripts-3.2
		>=sys-apps/daemontools-0.76-r1
		sys-apps/shadow"
PROVIDE="virtual/mta"

NULLMAILER_GROUP_NAME=nullmail
NULLMAILER_GROUP_GID=88
NULLMAILER_USER_NAME=nullmail
NULLMAILER_USER_UID=88
NULLMAILER_USER_SHELL=/bin/false
NULLMAILER_USER_GROUPS=nullmail
NULLMAILER_USER_HOME=/var/nullmailer

setupuser() {
	enewgroup ${NULLMAILER_GROUP_NAME} ${NULLMAILER_GROUP_GID}
	enewuser ${NULLMAILER_USER_NAME} ${NULLMAILER_USER_UID} ${NULLMAILER_USER_SHELL} ${NULLMAILER_USER_HOME} ${NULLMAILER_USER_GROUPS}
}

pkg_setup() {
	setupuser
}

src_compile() {
	# Note that we pass a different directory below due to bugs in the makefile!
	econf --localstatedir=/var || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall localstatedir=${D}/var/nullmailer || die "einstall failed"
	mv ${D}/usr/sbin/sendmail ${D}/usr/sbin/sendmail.nullmailer
	mv ${D}/usr/bin/mailq ${D}/usr/bin/mailq.nullmailer
	dodoc AUTHORS BUGS COPYING HOWTO INSTALL NEWS README YEAR2000 TODO ChangeLog
	# A small bit of sample config
	dodir /etc/nullmailer
	cp ${FILESDIR}/remotes.sample ${D}/etc/nullmailer/remotes
	# daemontools stuff
	dodir /var/nullmailer/service{,/log}
	cp scripts/nullmailer.run ${D}/var/nullmailer/service/run
	fperms 700 /var/nullmailer/service/run
	cp scripts/nullmailer-log.run ${D}/var/nullmailer/service/log/run
	fperms 700 /var/nullmailer/service/log/run
	# usablity
	dodir /usr/lib
	dosym /usr/sbin/sendmail usr/lib/sendmail
	# permissions stuff
	keepdir /var/log/nullmailer /var/nullmailer/{tmp,queue}
	fperms 770 /var/log/nullmailer /var/nullmailer/{tmp,queue}
	fowners nullmail:nullmail /usr/sbin/nullmailer-queue /usr/bin/mailq
	fperms 4711 /usr/sbin/nullmailer-queue /usr/bin/mailq
	fowners nullmail:nullmail /var/log/nullmailer /var/nullmailer/{tmp,queue,trigger}
	fperms 660 /var/nullmailer/trigger
	ewarn "Please ensure you have selected nullmailer in your /etc/mailer.conf"
}

pkg_config() {
	[ ! -s /etc/nullmailer/me ] && /bin/hostname --fqdn >/etc/nullmailer/me
	[ ! -s /etc/nullmailer/defaultdomain ] && /bin/hostname --domain >/etc/nullmailer/defaultdomain
	ewarn "Please ensure you have selected nullmailer in your /etc/mailer.conf"
}

pkg_postinst() {
	setupuser
	# Do this again for good measure
	[ ! -e /var/nullmailer/trigger ] && mkfifo /var/nullmailer/trigger
	chown nullmail:nullmail /var/log/nullmailer /var/nullmailer/{tmp,queue,trigger}
	chmod 770 /var/log/nullmailer /var/nullmailer/{tmp,queue}
	chmod 660 /var/nullmailer/trigger

	TMP_P="${PN}-${PV}"
	[ "${PR}" != "r0" ] && TMP_P="${TMP_P}-${PR}"
	einfo "To create an initial setup, please do:"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${TMP_P}/${TMP_P}.ebuild config"
	einfo "To start nullmailer at boot you have to enable the /etc/init.d/svscan rc file"
	einfo "and create the following links :"
	einfo "ln -fs /var/nullmailer/service /service/nullmailer"
	ewarn "Please ensure you have selected nullmailer in your /etc/mailer.conf"
}

