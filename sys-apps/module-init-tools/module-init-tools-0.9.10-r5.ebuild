# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/module-init-tools/module-init-tools-0.9.10-r5.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

# This ebuild includes backwards compatability for stable 2.4 kernels
IUSE=""

inherit flag-o-matic
inherit eutils

# Note to Azarah:
#
# Hi Azarah :) That "above" and "below" stuff messes up 2.4 modutils too,
# but for different reasons. So I am removing all the weird hacks to keep
# "above" and "below" since they are no longer necessary.
#
# <drobbins@gentoo.org> (24 March 2003)

MYP="${P/_pre1/-pre}"
S="${WORKDIR}/${MYP}"
MODUTILS_PV="2.4.24"
DESCRIPTION="Kernel module tools for the development kernel >=2.5.48"
SRC_URI="mirror://kernel/linux/kernel/people/rusty/modules/${MYP}.tar.bz2
	mirror://kernel/linux/utils/kernel/modutils/v2.4/modutils-${MODUTILS_PV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/rusty/modules"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha ~mips ~arm"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/devfsd-1.3.25-r1"
PROVIDE="virtual/modutils"

pkg_setup() {
	check_KV

	if [ ! -f /lib/modules/${KV}/modules.dep ]
	then
		eerror "Please compile and install a kernel first!"
		die "Please compile and install a kernel first!"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix recursive calls to modprobe not honoring -s, -q, -v and -C
	epatch ${FILESDIR}/${P}-fix-recursion.patch
	# Never output to stdout if logging was requested
	epatch ${FILESDIR}/${P}-no-stdout-on-log.patch
	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	epatch ${FILESDIR}/modutils-2.4.22-no-above-below.patch
	cd ${S}

	# If we call modprobe with '-C /dev/modules.conf' and the "module name"
	# starts with '/dev', modprobe from modutils-2.4.22 do not print any
	# errors:
	#
	#   gateway root # modprobe /dev/sd1   
	#   modprobe: Can't locate module /dev/sd1
	#   gateway root # modprobe -C /etc/modules.conf /dev/sd1
	#   modprobe: Can't locate module /dev/sd1
	#   gateway root # modprobe -C /etc/modules.devfs /dev/sd1
	#   gateway root # modprobe foo     
	#   modprobe: Can't locate module foo
	#   gateway root # modprobe -C /etc/modules.conf foo     
	#   modprobe: Can't locate module foo
	#   gateway root # modprobe -C /etc/modules.devfs foo     
	#   modprobe: Can't locate module foo
	#   gateway root # 
	#   gateway root # modprobe -C /etc/modules.devfs /dev/sd1 && echo yes
	#   yes
	#   gateway root # modprobe -C /etc/modules.devfs foo && echo yes
	#   modprobe: Can't locate module foo
	#   gateway root # 
	epatch ${FILESDIR}/${P}-be-quiet-for-devfsd.patch
}

src_compile() {
	local myconf
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
	for f in lsmod modprobe rmmod depmod insmod; do
		if [ -L ${D}/sbin/${f} ]; then
			ln -sf `ls -l ${D}/sbin/${f} | \
				sed 's/.* -> //'`.old ${D}/sbin/${f};
		fi;
		mv ${D}/sbin/${f} ${D}/sbin/${f}.old;
	done
	einstall prefix=${D}
	# Install the modules.conf2modprobe.conf tool, so we can update
	# modprobe.conf.
	into /
	dosbin ${S}/generate-modprobe.conf
	# Create the new modprobe.conf
	dodir /etc
	rm -f ${D}/etc/modprobe.conf
	if [ ! -f ${ROOT}/etc/modprobe.devfs ]; then
		# Support file for the devfs hack .. needed else modprobe borks.
		# Baselayout-1.8.6.3 or there abouts will have a modules-update that
		# will correctly generate /etc/modprobe.devfs ....
		echo "### This file is automatically generated by modules-update" \
			> ${D}/etc/modprobe.devfs
	else
		# This is dynamic, so we do not want this in the package ...
		rm -f ${D}/etc/modprobe.devfs
	fi

	docinto
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]; then
		einfo "Updating config files..."
		if [ -x /sbin/modules-update ]; then
			/sbin/modules-update
		elif [ -x /sbin/update-modules ]; then
			/sbin/update-modules
		elif [ -x /usr/sbin/update-modules ]; then
			/usr/sbin/update-modules
		fi
	fi
}
