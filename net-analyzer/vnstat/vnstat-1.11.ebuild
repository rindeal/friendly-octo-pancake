# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.11.ebuild,v 1.2 2011/06/06 07:41:54 radhermit Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Console-based network traffic monitor that keeps statistics of network usage"
HOMEPAGE="http://humdi.net/vnstat/"
SRC_URI="http://humdi.net/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="gd"

DEPEND="
	gd? ( media-libs/gd[png] )"
RDEPEND="${DEPEND}
	virtual/cron"

pkg_setup() {
	enewgroup vnstat
	enewuser vnstat -1 -1 /dev/null vnstat
}

src_compile() {
	sed -i 's:vnstat[.]log:vnstatd.log:' cfg/vnstat.conf || die
	sed -i 's:vnstat[.]pid:vnstatd/vnstatd.pid:' cfg/vnstat.conf || die

	if use gd; then
		emake all CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
	else
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
	fi
}

src_install() {
	use gd && dobin src/vnstati
	dobin src/vnstat src/vnstatd
	exeinto /etc/cron.hourly
	newexe "${FILESDIR}"/vnstat.cron vnstat

	insinto /etc
	doins cfg/vnstat.conf
	fowners root:vnstat /etc/vnstat.conf

	newconfd "${FILESDIR}/vnstatd.confd" vnstatd
	newinitd "${FILESDIR}/vnstatd.initd" vnstatd

	keepdir /var/lib/vnstat
	keepdir /var/run/vnstatd
	fowners vnstat:vnstat /var/lib/vnstat
	fowners vnstat:vnstat /var/run/vnstatd

	use gd && doman man/vnstati.1
	doman man/vnstat.1 man/vnstatd.1

	newdoc examples/vnstat_ip-up ip-up.example
	newdoc examples/vnstat_ip-down ip-down.example
	newdoc INSTALL README.setup
	dodoc CHANGES README UPGRADE FAQ examples/vnstat.cgi
}

pkg_postinst() {
	# Workaround feature/bug #141619
	chown -R vnstat:vnstat "${ROOT}/var/lib/vnstat"
	chown vnstat:vnstat "${ROOT}/var/run/vnstatd"
	ewarn "vnStat db files owning user and group has been changed to \"vnstat\"."

	elog
	elog "Repeat the following command for every interface you"
	elog "wish to monitor (replace eth0):"
	elog "   vnstat -u -i eth0"
	elog "and set correct permissions after that, e.g."
	elog "   chown -R vnstat:vnstat /var/lib/vnstat"
	elog
	elog "Note: if an interface transfers more than ~4GB in"
	elog "the time between cron runs, you may miss traffic"
	elog
	elog "To update the interfaces database automatically with cron, uncomment"
	elog "lines in /etc/cron.hourly/vnstat and set cron job to run it as"
	elog "frequently as required. Alternatively you can use vnstatd. Init script"
	elog "was installed into /etc/init.d/vnstatd for your convenience."
}
