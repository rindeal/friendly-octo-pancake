# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/module-init-tools/module-init-tools-0.9.11a.ebuild,v 1.3 2003/06/21 21:19:40 drobbins Exp $

# This ebuild includes backwards compatability for stable 2.4 kernels
IUSE=""

inherit flag-o-matic
inherit eutils

MYP="${P/_pre1/-pre}"
S="${WORKDIR}/${MYP}"
MODUTILS_PV="2.4.25"
DESCRIPTION="Kernel module tools for the development kernel >=2.5.48"
SRC_URI="mirror://kernel/linux/kernel/people/rusty/modules/${MYP}.tar.bz2
	mirror://kernel/linux/utils/kernel/modutils/v2.4/modutils-${MODUTILS_PV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/rusty/modules"

KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha ~mips ~arm"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}

	# With the b0rked modutils, "modprobe hid" does work. But if something
	# (like hotplug) tries to auto-load hid (because another module needs it,
	# via the kernel module auto-loader) and keybdev.o or mousedev.o don't
	# exist, then the "above" clause fails and the hid module never gets
	# loaded, and then things like USB will fail.  Thus we remove it all
	# together.
	#
	# <drobbins@gentoo.org> (26 Mar 2003)
	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	epatch ${FILESDIR}/modutils-2.4.22-no-above-below.patch
	
    # A hack to have absolutely no output if:
    #
    #   1) we have no logging enabled
    # 
    #   2) our config file is /etc/modprobe.devfs or /etc/modules.devfs
    #   
    #   3) with the module name starting with '/dev/'.
    #
    # Rasionale:  This is what modprobe from modutils does.
    #
    # <azarah@gentoo.org> (17 Mar 2003)
    cd ${S}; epatch ${FILESDIR}/${PN}-0.9.11-be-quiet-for-devfsd.patch
}

src_compile() {
	local myconf=
	
	filter-flags -fPIC

	einfo "Building modutils..."
	cd ${WORKDIR}/modutils-${MODUTILS_PV}

	econf \
		--disable-strip \
		--prefix=/ \
		--enable-insmod-static \
		--disable-zlib \
		${myconf}
	
	emake || die "emake modutils failed"
	einfo "Building module-init-tools..."
	cd ${S}

	econf \
		--prefix=/ \
		${myconf}

	emake || die "emake module-init-tools failed"
}

src_install () {

	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	einstall prefix="${D}"

	docinto modutils-${MODUTILS_PV}
	dodoc COPYING CREDITS ChangeLog NEWS README TODO

	cd ${S}
	# This copies the old version of modutils to *.old so it still works
	# with kernels <= 2.4; new versions will execve() the .old version if
	# a 2.4 kernel is running...
	# This code was borrowed from the module-init-tools Makefile
	local runme
	local f
	for f in lsmod modprobe rmmod depmod insmod modinfo
	do
		if [ -L ${D}/sbin/${f} ]
		then
			einfo "Moving symlink $f to ${f}.old"
			#runme = the target of the symlink with a .old tagged on.
			runme=`ls -l ${D}/sbin/${f} | sed 's/.* -> //'`.old
			[ ! -e ${D}/sbin/${runme} ] || einfo "${D}/sbin/${runme} not found"
			ln -snf $runme ${D}/sbin/${f} || die
		elif [ -e ${D}/sbin/${f} ]
		then
			einfo "Moving executable $f to ${f}.old"
		fi
		mv -f ${D}/sbin/${f} ${D}/sbin/${f}.old;
	done
	# Move the man pages as well.  We only do this for the man pages of the
	# tools that module-init-tools will replace.
	for f in ${D}/usr/share/man/man8/{lsmod,modprobe,rmmod,depmod,insmod}.8
	do
		mv -f ${f} ${f%\.*}.old.${f##*\.}
	done
	
	einstall prefix=${D}

	# Install compat symlink
	dosym ../bin/lsmod /sbin/lsmod
	dosym ../sbin/insmod.old /bin/lsmod.old
	# Install the modules.conf2modprobe.conf tool, so we can update
	# modprobe.conf.
	into /
	dosbin ${S}/generate-modprobe.conf
	# Create the new modprobe.conf
	dodir /etc
	rm -f ${D}/etc/modprobe.conf
	if [ ! -f ${ROOT}/etc/modprobe.devfs ]
	then
		# Support file for the devfs hack .. needed else modprobe borks.
		# Baselayout-1.8.6.3 or there abouts will have a modules-update that
		# will correctly generate /etc/modprobe.devfs ....
		echo "### This file is automatically generated by modules-update" \
			> ${D}/etc/modprobe.devfs
	else
		# This is dynamic, so we do not want this in the package ...
		rm -f ${D}/etc/modprobe.devfs
	fi

	doman *.[1-8]
	docinto /
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		einfo "Updating config files..."
		if [ -x /sbin/modules-update ]
		then
			/sbin/modules-update
		elif [ -x /sbin/update-modules ]
		then
			/sbin/update-modules
		elif [ -x /usr/sbin/update-modules ]
		then
			/usr/sbin/update-modules
		fi
	fi
}

