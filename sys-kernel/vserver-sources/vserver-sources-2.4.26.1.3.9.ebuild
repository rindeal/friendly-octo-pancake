# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.4.26.1.3.9.ebuild,v 1.2 2004/06/03 12:15:29 plasmaroo Exp $

ETYPE="sources"
inherit kernel eutils
OKV=2.4.26
KV=2.4.26

## idea: after the kernel-version (2.4.26) we append the vs-version (e.g. 1.3.9) to
## get 2.4.25.1.3.9 that is globbed out here:
EXTRAVERSION="-vs${PV#*.*.*.}"

S=${WORKDIR}/linux-${KV}
# What's in this kernel?

# INCLUDED:
# stock 2.4.26 kernel sources (or newer)
# devel-version of vsever-patch: 1.3.9 (or newer)

DESCRIPTION="Linux kernel with DEVEL version ctx-/vserver-patch"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.13thfloor.at/vserver/d_release/${EXTRAVERSION/-vs/v}/linux-vserver-${EXTRAVERSION/-vs/}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.13thfloor.at/vserver/ http://www.linux-vserver.org/"

KEYWORDS="~x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	cd ${WORKDIR}
	mv linux-${OKV} linux-${KV}${EXTRAVERSION}

	tar xvjf ${DISTDIR}/linux-vserver-${EXTRAVERSION/-vs/}.tar.bz2 || die "Unpacking patch failed!"

	cd linux-${KV}${EXTRAVERSION}
	epatch ${WORKDIR}/patch-${KV}${EXTRAVERSION}.diff
	epatch ${FILESDIR}/${P}.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"

	kernel_universal_unpack
}
