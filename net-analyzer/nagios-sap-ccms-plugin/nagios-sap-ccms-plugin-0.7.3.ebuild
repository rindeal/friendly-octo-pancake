# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-sap-ccms-plugin/nagios-sap-ccms-plugin-0.7.3.ebuild,v 1.4 2007/06/30 16:39:48 dertobi123 Exp $

MY_P="sap-ccms-plugin-${PV}"

DESCRIPTION="Nagios plugin that provides an interface to SAP CCMS
Infrastructure"
HOMEPAGE="http://sourceforge.net/projects/nagios-sap-ccms/"
SRC_URI="mirror://sourceforge/nagios-sap-ccms/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="net-analyzer/nagios-core"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}

src_compile() {
	cd "${S}/src"
	emake || die "emake failed"
}


src_install() {
	cd "${S}/src"
	exeinto /usr/nagios/libexec/

	for file in {check_sap{,_cons,_instance,_instance_cons,_mult_no_thr,_multiple,_system,_system_cons},create_cfg,sap_change_thr}
	do
		doexe ${file}
	done

	chown -R root:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}usr/nagios/libexec"

	dolib.so sap_moni.so
	cd ${S}/config

	dodir /etc/sapmon
	insinto /etc/sapmon
	doins ${S}/config/*
}

pkg_postinst() {
	elog "Have a look at /etc/sapmon for configuring ${PN}"
	elog "Further information can be found at"
	elog "http://nagios-sap-ccms.sourceforge.net/"
}
