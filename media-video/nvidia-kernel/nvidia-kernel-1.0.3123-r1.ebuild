# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.3123-r1.ebuild,v 1.2 2002/12/09 04:26:14 manson Exp $

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_kernel-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}"
DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
SRC_URI="http://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

# The slow needs to be set to $KV to prevent unmerges of
# modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/linux-sources
	>=sys-apps/portage-1.9.10"


src_unpack() {
	unpack ${A}

	# Next section applies patches for linux-2.5 kernel, or if
	# linux-2.4, the page_alloc.c patch courtesy of NVIDIA Corporation.
	# All these are from:
	#
	#   http://www.minion.de/nvidia/
	#
	# Many thanks to Christian Zander <zander@minion.de> for bringing
	# these to us, and being so helpful to select which to use.
	# This should close bug #9704.
	
	local KV_major="`uname -r | cut -d. -f1`"
	local KV_minor="`uname -r | cut -d. -f2`"

	cd ${S}
	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
	then
		einfo "Applying patches for kernel 2.5..."
		patch -p1 < ${FILESDIR}/${NV_PACKAGE}-2.5.diff >/dev/null || die
		einfo "Applying page_alloc.c patch..."
		patch -p1 < ${FILESDIR}/${NV_PACKAGE}-2.5-pa.diff >/dev/null || die
	else
		einfo "Applying page_alloc.c patch..."
		patch -p1 < ${FILESDIR}/${NV_PACKAGE}-pa.diff >/dev/null || die
	fi
}

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	#IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	#updated but the running kernel is still compiled with an older gcc.  This is
	#needed for chrooted building, where the sanity check detects the gcc of the
	#kernel outside the chroot rather than within.
	make IGNORE_CC_MISMATCH="yes" KERNDIR="/usr/src/linux" \
		clean NVdriver || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/video
	doins NVdriver
    
	# Add the aliases
	insinto /etc/modules.d
	doins ${FILESDIR}/nvidia

	# Docs
	dodoc ${S}/README

	# The device creation script
	into /
	newsbin ${S}/makedevices.sh NVmakedevices.sh
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		if [ ! -e /dev/.devfsd ] && [ -x /sbin/NVmakedevices.sh ]
		then
			/sbin/NVmakedevices.sh >/dev/null 2>&1
		fi
	fi

	einfo "If you are not using devfs, loading the module automatically at"
	einfo "boot up, you need to add \"NVdriver\" to your /etc/modules.autoload."
	einfo
}

