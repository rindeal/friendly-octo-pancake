# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/clamav/clamav-0.81.ebuild,v 1.1 2005/01/27 08:39:02 ticho Exp $

inherit eutils flag-o-matic

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/clamav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~hppa ~alpha ~ppc64"
IUSE="crypt selinux"

DEPEND="virtual/libc
	crypt? ( >=dev-libs/gmp-4.1.2 )"
RDEPEND="selinux? ( sec-policy/selinux-clamav )"
PROVIDE="virtual/antivirus"

#S="${WORKDIR}/${P/_/}"

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	has_version =sys-libs/glibc-2.2* && filter-lfs-flags

	local myconf

	# Disabled milter useflag, since it needs libmilter, which is not in portage
	# - ticho (2005-01-27)
	#use milter && myconf="--enable-milter"
	econf ${myconf} --with-dbdir=/var/lib/clamav || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
	exeinto /etc/init.d ; newexe ${FILESDIR}/clamd.rc clamd
	insinto /etc/conf.d ; newins ${FILESDIR}/clamd.conf clamd
	dodoc ${FILESDIR}/clamav-milter.README.gentoo
}

pkg_postinst() {
	echo
	einfo "NOTE: As of clamav-0.80, the config file for clamd is no longer"
	einfo "      /etc/clamav.conf, but /etc/clamd.conf. Adjust your"
	einfo "      configuration accordingly before (re)starting clamd."
	echo
	ewarn "Warning: clamd and/or freshclam have not been restarted."
	ewarn "You should restart them with: /etc/init.d/clamd restart"
	echo
	#if use milter ; then
	#	einfo "For simple instructions howto setup the clamav-milter..."
	#	einfo ""
	#	einfo "less /usr/share/doc/${PF}/clamav-milter.README.gentoo.gz"
	#	echo
	#fi
}
