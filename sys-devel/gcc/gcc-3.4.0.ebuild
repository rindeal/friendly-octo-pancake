# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.4.0.ebuild,v 1.9 2004/04/27 16:57:10 lv Exp $

IUSE="static nls bootstrap java build X multilib gcj hardened f77 objc uclibc"

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++ and java compilers, as well as support for pax PIE"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"

# Install this and I cannot be held responsible for system failure, random
# bugs, or sudden onset of insanity. YOU HAVE BEEN WARNED!! (though, really,
# 3.4 appears to be safe in general unless you're compiling binutils)
KEYWORDS="-*"
#KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~mips ~ia64 ~ppc64 ~hppa ~alpha ~s390"

# PIE support
PIE_VER="8.5.3"
# forward port of the gcc 3.3 version, only with SSP disabled until
# a port of propolice to 3.4 is completed.
PIE_BASE_URI="mirror://gentoo/"
PIE_SSP_PATCH="gcc-3.4.0-v${PIE_VER}-nodefault-pie-ssp.patch"
PIE_EXCLUSION_PATCH="gcc-3.3.3-v${PIE_VER}-gcc-exclusion.patch"
SRC_URI="${PIE_BASE_URI}${PIE_SSP_PATCH}
	${PIE_BASE_URI}${PIE_EXCLUSION_PATCH}"

inherit eutils flag-o-matic libtool

# Recently there has been a lot of stability problems in Gentoo-land.  Many
# things can be the cause to this, but I believe that it is due to gcc3
# still having issues with optimizations, or with it not filtering bad
# combinations (protecting the user maybe from himeself) yet.
#
# This can clearly be seen in large builds like glibc, where too aggressive
# CFLAGS cause the tests to fail miserbly.
#
# Quote from Nick Jones <carpaski@gentoo.org>, who in my opinion
# knows what he is talking about:
#
#   People really shouldn't force code-specific options on... It's a
#   bad idea. The -march options aren't just to look pretty. They enable
#   options that are sensible (and include sse,mmx,3dnow when apropriate).
#
# The next command strips CFLAGS and CXXFLAGS from nearly all flags.  If
# you do not like it, comment it, but do not bugreport if you run into
# problems.
#
# <azarah@gentoo.org> (13 Oct 2002)
do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	export GCJFLAGS="${CFLAGS/-O?/-O2}"
}

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"

# GCC 3.4 no longer uses gcc-lib. we'll rename this later for compatibility
# reasons, as a few things would break without gcc-lib.
LIBPATH="${LOC}/lib/gcc/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

# GCC 3.4 introduces a new version of libstdc++
if [ "${CHOST}" == "${CCHOST}" ]
then
	SLOT="${MY_PV}"
else
	SLOT="${CCHOST}-${MY_PV}"
fi

# Patch tarball support ...
PATCH_VER=
# Snapshot support ...
SNAPSHOT=
# Branch update support ...
MAIN_BRANCH="${PV}"  # Tarball, etc used ...
BRANCH_UPDATE=

# poof! like magic!
if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${PN}-${MAIN_BRANCH}"
	SRC_URI="${SRC_URI}
		ftp://gcc.gnu.org/pub/gcc/releases/${P}/${PN}-${MAIN_BRANCH}.tar.bz2"

	if [ -n "${PATCH_VER}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
	fi

	if [ -n "${BRANCH_UPDATE}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2"
	fi
else
	S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	SRC_URI="${SRC_URI}
		ftp://sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
fi

# PERL cannot be present at bootstrap, and is used to build the man pages. So..
# lets include some pre-generated ones, shall we?
SRC_URI="${SRC_URI} mirror://gentoo/${P}-manpages.tar.bz2"

# We need the later binutils for support of the new cleanup attribute.
# 'make check' fails for about 10 tests (if I remember correctly) less
# if we use later bison.
DEPEND="virtual/glibc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	!amd64? ( hardened? ( >=sys-libs/glibc-2.3.3_pre20040207 ) )
	( !sys-devel/hardened-gcc )
	>=sys-devel/binutils-2.14.90.0.8-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-baselibs-1.0 ) )
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/glibc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	hardened? ( !amd64? ( >=sys-libs/glibc-2.3.3_pre20040207 ) )
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config"


chk_gcc_version() {
	# This next bit is for updating libtool linker scripts ...
	local OLD_GCC_VERSION="`gcc -dumpversion`"
	local OLD_GCC_CHOST="$(gcc -v 2>&1 | egrep '^Reading specs' |\
	                       sed -e 's:^.*/gcc-lib/\([^/]*\)/[0-9]\+.*$:\1:')"

	if [ "${OLD_GCC_VERSION}" != "${MY_PV_FULL}" ]
	then
		echo "${OLD_GCC_VERSION}" > "${WORKDIR}/.oldgccversion"
	fi

	if [ -n "${OLD_GCC_CHOST}" ]
	then
		if [ "${CHOST}" = "${CCHOST}" -a "${OLD_GCC_CHOST}" != "${CHOST}" ]
		then
			echo "${OLD_GCC_CHOST}" > "${WORKDIR}/.oldgccchost"
		fi
	fi

	# Did we check the version ?
	touch "${WORKDIR}/.chkgccversion"
}

version_patch() {
	[ ! -f "$1" ] && return 1
	[ -z "$2" ] && return 1

	sed -e "s:@GENTOO@:$2:g" ${1} > ${T}/${1##*/}
	epatch ${T}/${1##*/}
}

glibc_have_ssp() {
	local my_libc="${ROOT}/lib/libc.so.6"

# Not necessary. lib64 is a symlink to /lib. -- avenj@gentoo.org  3 Apr 04
#	case "${ARCH}" in
#		"amd64")
#			my_libc="${ROOT}/lib64/libc.so.?"
#			;;
#	esac

	# Check for the glibc to have the __guard symbols
	if  [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep OBJECT | grep '__guard')" ] && \
	    [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep FUNC | grep '__stack_smash_handler')" ]
	then
		return 0
	else
		return 1
	fi
}

check_glibc_ssp() {
	if glibc_have_ssp
	then
		if [ -n "${GLIBC_SSP_CHECKED}" ] && \
		   [ -z "$(readelf -s  "${ROOT}/$(gcc-config -L)/libgcc_s.so" 2>/dev/null | \
		           grep 'GLOBAL' | grep 'OBJECT' | grep '__guard')" ]
		then
			# No need to check again ...
			return 0
		fi

		echo
		ewarn "This sys-libs/glibc has __guard object and __stack_smash_handler functions"
		ewarn "scanning the system for binaries with __guard - this may take 5-10 minutes"
		ewarn "Please do not press ctrl-C or ctrl-Z during this period - it will continue"
		echo
		if ! bash ${FILESDIR}/scan_libgcc_linked_ssp.sh
		then
			echo
			eerror "Found binaries that are dynamically linked to the libgcc with __guard@@GCC"
			eerror "You need to compile these binaries without CFLAGS -fstack-protector/hcc -r"
			echo
			eerror "Also, you have to make sure that using ccache needs the cache to be flushed"
			eerror "wipe out /var/tmp/ccache or /root/.ccache.  This will remove possible saved"
			eerror "-fstack-protector arguments that still may reside in such a compiler cache"
			echo
			eerror "When such binaries are found, gcc cannot remove libgcc propolice functions"
			eerror "leading to gcc -static -fstack-protector breaking, see gentoo bug #25299"
			echo
			einfo  "To do a full scan on your system, enter this following command in a shell"
			einfo  "(Please keep running and remerging broken packages until it do not report"
			einfo  " any breakage anymore!):"
			echo
			einfo  " # ${FILESDIR}/scan_libgcc_linked_ssp.sh"
			echo
			die "Binaries with libgcc __guard@GCC dependencies detected!"
		else
			echo
			einfo "No binaries with suspicious libgcc __guard@GCC dependencies detected"
			echo
		fi
	fi

	return 0
}

update_gcc_for_libc_ssp() {
	if glibc_have_ssp
	then
		einfo "Updating gcc to use SSP from glibc..."
		sed -e 's|^\(LIBGCC2_CFLAGS.*\)$|\1 -D_LIBC_PROVIDES_SSP_|' \
			-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"
	fi
}

src_unpack() {
	# I think it's a little messed up to allow people to compile just to have
	# it fail right near the end, so lets die right away when parts that are
	# known to be broken are going to be compiled.
	# Travis Tilley <lv@gentoo.org>
	use java && use gcj && die "gcj will not compile yet with gcc 3.4.0. re-emerge with USE=-gcj"
	use amd64 && use multilib && die "multilib support will not compile yet with gcc 3.4.0. re-emerge with USE=-multilib"


	local release_version="Gentoo Linux ${PVR}"

	ewarn "Do not hold me accountable if GCC 3.4 makes things unstable, wont"
	ewarn "compile your favorite piece of software, breaks anything C++"
	ewarn "that you compiled with it after uninstalling gcc 3.4, miscompiles"
	ewarn "binutils at optimisation levels greater than -O2, eats your cat,"
	ewarn "humps your leg, or pees on your rug. YOU HAVE BEEN WARNED!!!"
	ewarn "ALSO DO NOT BOTHER TSENG OR GENTOO-HARDENED ABOUT GCC 3.4"
	ewarn "While this may be a final release, numerous problems still exist"

	if [ -z "${SNAPSHOT}" ]
	then
		unpack ${PN}-${MAIN_BRANCH}.tar.bz2

		if [ -n "${PATCH_VER}" ]
		then
			unpack ${P}-patches-${PATCH_VER}.tar.bz2
		fi
	else
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	# Branch update ...
	if [ -n "${BRANCH_UPDATE}" ]
	then
		epatch ${DISTDIR}/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	# Do bulk patches included in ${P}-patches-${PATCH_VER}.tar.bz2
	if [ -n "${PATCH_VER}" ]
	then
		mkdir -p ${WORKDIR}/patch/exclude
#		mv -f ${WORKDIR}/patch/{40,41}* ${WORKDIR}/patch/exclude/
		mv -f ${WORKDIR}/patch/41* ${WORKDIR}/patch/exclude/
		epatch ${WORKDIR}/patch
	fi

	echo

	if [ -n "`use multilib`" -a "${ARCH}" = "amd64" ]
	then
		epatch ${FILESDIR}/gcc331_use_multilib.amd64.patch
	fi

	# This patch enables improved PIE and SSP behaviour but does not
	# enable it by default ...
	cd ${S} && epatch "${DISTDIR}/${PIE_SSP_PATCH}"
	use uclibc || epatch ${DISTDIR}/${PIE_EXCLUSION_PATCH}
	release_version="${release_version}, pie-${PIE_VER}"

	if [ -n "`use hardened`" ]
	then
		einfo "Updating gcc to use automatic PIE + SSP building ..."
		sed -e 's|^ALL_CFLAGS = |ALL_CFLAGS = -DEFAULT_PIE_SSP -fPIC|' \
			-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"

		# rebrand to make bug reports easier
		release_version="${release_version/Gentoo/Gentoo Hardened}"
	fi

	version_patch ${FILESDIR}/3.4.0/gcc-${PV}-gentoo-branding.patch \
		"${BRANCH_UPDATE} (${release_version})" || die "Failed Branding"

	# TODO: on arches where we lack a Scrt1.o (like parisc) we still need unpack, compile and install logic
	# TODO: for the crt1Snocsu.o provided by a custom gcc-pie-ssp.tgz which can also be included in SRC_URI

	# Install our pre generated manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		cd ${S}; unpack ${P}-manpages.tar.bz2
	fi

	# Misdesign in libstdc++ (Redhat)
	cp -a ${S}/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
}

src_compile() {

	local myconf=
	local gcc_lang=

	if ! use build
	then
		myconf="${myconf} --enable-shared"
		gcc_lang="c,c++"
		use f77 && gcc_lang="${gcc_lang},f77"
		use objc && gcc_lang="${gcc_lang},objc"
		use java && use gcj && gcc_lang="${gcc_lang},java"
		# ADA is supported elsewhere, do not enable it here
		# use ada  && gcc_lang="${gcc_lang},ada"
	else
		gcc_lang="c"
	fi
	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	# Enable building of the gcj Java AWT & Swing X11 backend
	# if we have X as a use flag and are not in a build stage.
	# X11 support is still very experimental but enabling it is
	# quite innocuous...  [No, gcc is *not* linked to X11...]
	# <dragon@gentoo.org> (15 May 2003)
	if [ -n "`use java`" -a -n "`use gcj`" -a \
	     -n "`use X`" -a -z "`use build`" -a \
	     -f /usr/X11R6/include/X11/Xlib.h ]
	then
		myconf="${myconf} --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib"
		myconf="${myconf} --enable-interpreter --enable-java-awt=xlib --with-x"
	fi

	# Multilib not yet supported
	if [ -n "`use multilib`" -a "${ARCH}" = "amd64" ]
	then
		einfo "WARNING: Multilib support enabled. This is still experimental."
		myconf="${myconf} --enable-multilib"
	else
		if [ "${ARCH}" = "amd64" ]
		then
			einfo "WARNING: Multilib not enabled. You will not be able to build 32bit binaries."
		fi
		myconf="${myconf} --disable-multilib"
	fi

	# Fix linking problem with c++ apps which where linkedi
	# agains a 3.2.2 libgcc
	[ "${ARCH}" = "hppa" ] && myconf="${myconf} --enable-sjlj-exceptions"

	use hardened && append-flags -fPIC

	# Default arch support
	use amd64 && myconf="${myconf} --with-cpu=k8 --with-arch=k8"
	#use s390 && myconf="${myconf} --with-arch=nofreakingclue"
	use x86 && myconf="${myconf} --with-cpu=pentium4 --with-arch=i586"
	#use mips && myconf="${myconf} --with-arch=mips3"

	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""
	einfo "GCJFLAGS=\"${GCJFLAGS}\""

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-languages=${gcc_lang} \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		--disable-werror \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		find ${S} -name '*.[17]' -exec touch {} \; || :
	fi

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Building GCC..."
	# Only build it static if we are just building the C frontend, else
	# a lot of things break because there are not libstdc++.so ....
	if [ -n "`use static`" -a "${gcc_lang}" = "c" ]
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake LDFLAGS="-static" bootstrap \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
		# Above FLAGS optimize and speedup build, thanks
		# to Jeff Garzik <jgarzik@mandrakesoft.com>
	else
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake profiledbootstrap \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die

	fi
}

src_install() {
	local x=

	# Dont allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
			continue
		fi
	done
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in `find ${WORKDIR}/build/gcc/include/ -name '*.h'`
	do
		if grep -q 'It has been auto-edited by fixincludes from' ${x}
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		DESTDIR="${D}" \
		LIBPATH="${LIBPATH}" \
		install || die

	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"

	# Because GCC 3.4 installs into the gcc directory and not the gcc-lib
	# directory, we will have to rename it in order to keep compatibility
	# with our current libtool check and gcc-config (which would be a pain
	# to fix compared to this simple mv and symlink).
	mv ${D}/${LOC}/lib/gcc ${D}/${LOC}/lib/gcc-lib
	ln -s gcc-lib ${D}/${LOC}/lib/gcc
	LIBPATH=${LIBPATH/lib\/gcc/lib\/gcc-lib}

	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	if [ -n "`use multilib`" -a "${ARCH}" = "amd64" ]
	then
		# amd64 is a bit unique because of multilib.  Add some other paths
		echo "LDPATH=\"${LIBPATH}:${LIBPATH}/32:${LIBPATH}/../lib64:${LIBPATH}/../lib32\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	else
		echo "LDPATH=\"${LIBPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	fi
	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if [ -z "`use build`" ]
	then
		cd ${D}${LIBPATH}

		# Tell libtool files where real libraries are
		for x in ${D}${LOC}/lib/*.la ${D}${LIBPATH}/../*.la
		do
			if [ -f "${x}" ]
			then
				sed -i -e "s:/usr/lib:${LIBPATH}:" ${x}
				mv ${x} ${D}${LIBPATH}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${D}${LIBPATH}/../*.{so,a}*
		do
			[ -f "${x}" -o -L "${x}" ] && mv -f ${x} ${D}${LIBPATH}
		done

		# Move Java headers to compiler-specific dir
		for x in ${D}${LOC}/include/gc*.h ${D}${LOC}/include/j*.h
		do
			[ -f "${x}" ] && mv -f ${x} ${D}${LIBPATH}/include/
		done
		for x in gcj gnu java javax org
		do
			if [ -d "${D}${LOC}/include/${x}" ]
			then
				dodir /${LIBPATH}/include/${x}
				mv -f ${D}${LOC}/include/${x}/* ${D}${LIBPATH}/include/${x}/
				rm -rf ${D}${LOC}/include/${x}
			fi
		done

		if [ -d "${D}${LOC}/lib/security" ]
		then
			dodir /${LIBPATH}/security
			mv -f ${D}${LOC}/lib/security/* ${D}${LIBPATH}/security
			rm -rf ${D}${LOC}/lib/security
		fi

		# Move libgcj.spec to compiler-specific directories
		[ -f "${D}${LOC}/lib/libgcj.spec" ] && \
			mv -f ${D}${LOC}/lib/libgcj.spec ${D}${LIBPATH}/libgcj.spec

		# Rename jar because it could clash with Kaffe's jar if this gcc is
		# primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/${CCHOST}/gcc-bin/${MY_PV}
		[ -f jar ] && mv -f jar gcj-jar

		# Move <cxxabi.h> to compiler-specific directories
		[ -f "${D}${STDCXX_INCDIR}/cxxabi.h" ] && \
			mv -f ${D}${STDCXX_INCDIR}/cxxabi.h ${D}${LIBPATH}/include/

		# These should be symlinks
		cd ${D}${BINPATH}
		for x in gcc g++ c++ g77 gcj
		do
			rm -f ${CCHOST}-${x}
			[ -f "${x}" ] && ln -sf ${x} ${CCHOST}-${x}

			if [ -f "${CCHOST}-${x}-${PV}" ]
			then
				rm -f ${CCHOST}-${x}-${PV}
				ln -sf ${x} ${CCHOST}-${x}-${PV}
			fi
		done
	fi

	# This one comes with binutils
	if [ -f "${D}${LOC}/lib/libiberty.a" ]
	then
		rm -f ${D}${LOC}/lib/libiberty.a
	fi
	if [ -f "${D}${LIBPATH}/libiberty.a" ]
	then
		rm -f ${D}${LIBPATH}/libiberty.a
	fi

	cd ${S}
	if [ -z "`use build`" ]
	then
		cd ${S}
		docinto /${CCHOST}
		dodoc COPYING COPYING.LIB ChangeLog* FAQ MAINTAINERS README
		docinto ${CCHOST}/html
		dohtml *.html
		cd ${S}/boehm-gc
		docinto ${CCHOST}/boehm-gc
		dodoc ChangeLog doc/{README*,barrett_diagram}
		docinto ${CCHOST}/boehm-gc/html
		dohtml doc/*.html
		cd ${S}/gcc
		docinto ${CCHOST}/gcc
		dodoc ChangeLog* FSFChangeLog* LANGUAGES NEWS ONEWS README* SERVICE
		if use f77
		then
			cd ${S}/libf2c
			docinto ${CCHOST}/libf2c
			dodoc ChangeLog* README TODO *.netlib
		fi
		cd ${S}/libffi
		docinto ${CCHOST}/libffi
		dodoc ChangeLog* LICENSE README
		cd ${S}/libiberty
		docinto ${CCHOST}/libiberty
		dodoc ChangeLog* COPYING.LIB README
		if use objc
		then
			cd ${S}/libobjc
			docinto ${CCHOST}/libobjc
			dodoc ChangeLog* README* THREADS*
		fi
		cd ${S}/libstdc++-v3
		docinto ${CCHOST}/libstdc++-v3
		dodoc ChangeLog* README
		docinto ${CCHOST}/libstdc++-v3/html
		dohtml -r -a css,diff,html,txt,xml docs/html/*
		cp -f docs/html/17_intro/[A-Z]* \
			${D}/usr/share/doc/${PF}/${DOCDESTTREE}/17_intro/

		if use java && use gcj
		then
			cd ${S}/fastjar
			docinto ${CCHOST}/fastjar
			dodoc AUTHORS CHANGES COPYING ChangeLog* NEWS README
			cd ${S}/libjava
			docinto ${CCHOST}/libjava
			dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
		fi

		prepman ${DATAPATH}
		prepinfo ${DATAPATH}
	else
		rm -rf ${D}/usr/share/{man,info}
		rm -rf ${D}${DATAPATH}/{man,info}
	fi

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
	insinto /lib/rcscripts/awk
	doins ${FILESDIR}/awk/fixlafiles.awk
	exeinto /sbin
	doexe ${FILESDIR}/fix_libtool_files.sh

	if [ "${ARCH}" = "amd64" ]
	then
		# GCC 3.4 tries to place libgcc_s in lib64, where it will never be
		# found. When multilib is enabled, it also places the 32bit version in
		# lib32. This problem could be handled by a symlink if you only plan on
		# having one compiler installed at a time, but since these directories
		# exist outside the versioned directories, versions from gcc 3.3 and
		# 3.4 will overwrite each other. not good.
		cp -pfd ${D}/${LIBPATH}/../lib64/libgcc_s* ${D}/${LIBPATH}
		use multilib && \
		cp -pfd ${D}/${LIBPATH}/../lib32/libgcc_s* ${D}/${LIBPATH}
	fi
}

pkg_preinst() {

	if [ ! -f "${WORKDIR}/.chkgccversion" ]
	then
		chk_gcc_version
	fi

	# Make again sure that the linker "should" be able to locate
	# libstdc++.so ...
	if [ -n "`use multilib`" -a "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	${ROOT}/sbin/ldconfig
}

pkg_postinst() {

	if [ -n "`use multilib`" -a "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	if [ "${ROOT}" = "/" -a "${COMPILER}" = "gcc3" -a "${CHOST}" = "${CCHOST}" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${MY_PV_FULL}
	fi

	# Update libtool linker scripts to reference new gcc version ...
	if [ "${ROOT}" = "/" ] && \
	   [ -f "${WORKDIR}/.oldgccversion" -o -f "${WORKDIR}/.oldgccchost" ]
	then
		local OLD_GCC_VERSION=
		local OLD_GCC_CHOST=

		if [ -f "${WORKDIR}/.oldgccversion" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccversion")" ]
		then
			OLD_GCC_VERSION="$(cat "${WORKDIR}/.oldgccversion")"
		else
			OLD_GCC_VERSION="${MY_PV_FULL}"
		fi

		if [ -f "${WORKDIR}/.oldgccchost" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccchost")" ]
		then
			OLD_GCC_CHOST="--oldarch $(cat "${WORKDIR}/.oldgccchost")"
		fi

		/sbin/fix_libtool_files.sh ${OLD_GCC_VERSION} ${OLD_GCC_CHOST}
	fi
}

