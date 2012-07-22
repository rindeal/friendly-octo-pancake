# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/nvidia-drivers/nvidia-drivers-304.22.ebuild,v 1.4 2012/07/22 21:47:42 cardoe Exp $

EAPI="2"

inherit eutils unpacker multilib portability versionator \
	linux-mod flag-o-matic nvidia-driver linux-info

X86_NV_PACKAGE="NVIDIA-Linux-x86-${PV}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"
X86_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86-${PV}"
AMD64_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86_64-${PV}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? ( http://us.download.nvidia.com/XFree86/Linux-x86/${PV}/${X86_NV_PACKAGE}.run )
	 amd64? ( http://us.download.nvidia.com/XFree86/Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )
	 amd64-fbsd? ( http://us.download.nvidia.com/XFree86/FreeBSD-x86_64/${PV}/${AMD64_FBSD_NV_PACKAGE}.tar.gz )
	 x86-fbsd? ( http://us.download.nvidia.com/XFree86/FreeBSD-x86/${PV}/${X86_FBSD_NV_PACKAGE}.tar.gz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="acpi multilib kernel_FreeBSD kernel_linux +tools"
RESTRICT="strip"
EMULTILIB_PKG="true"

COMMON="<x11-base/xorg-server-1.12.99
	kernel_linux? ( >=sys-libs/glibc-2.6.1 )
	multilib? ( app-emulation/emul-linux-x86-xlibs )
	>=app-admin/eselect-opengl-1.0.9
	app-admin/eselect-opencl"
DEPEND="${COMMON}
	kernel_linux? ( virtual/linux-sources )"
RDEPEND="${COMMON}
	x11-libs/libXvMC
	acpi? ( sys-power/acpid )
	tools? (
		dev-libs/atk
		dev-libs/glib
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/pango
	)"
PDEPEND=">=x11-libs/libvdpau-0.3-r1"

QA_TEXTRELS_x86="
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib/libXvMCNVIDIA.so.${PV}
	usr/lib/libcuda.so.${PV}
	usr/lib/libnvcuvid.so.${PV}
	usr/lib/libnvidia-cfg.so.${PV}
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/libnvidia-ml.so.${PV}
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib/xorg/modules/drivers/nvidia_drv.so"

QA_TEXTRELS_x86_fbsd="boot/modules/nvidia.ko
	usr/lib/opengl/nvidia/lib/libGL.so.1
	usr/lib/libnvidia-glcore.so.1
	usr/lib/libvdpau_nvidia.so.1
	usr/lib/libnvidia-cfg.so.1
	usr/lib/opengl/nvidia/extensions/libglx.so.1
	usr/lib/xorg/modules/drivers/nvidia_drv.so"

QA_TEXTRELS_amd64="usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libcuda.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}"

QA_EXECSTACK_x86="usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib/libXvMCNVIDIA.a:NVXVMC.o
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libcuda.so.${PV}
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0"

QA_EXECSTACK_amd64="usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/libcuda.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}
	usr/lib64/libXvMCNVIDIA.a:NVXVMC.o
	usr/lib64/libnvidia-cfg.so.${PV}
	usr/lib64/libnvidia-ml.so.${PV}
	usr/lib64/libvdpau_nvidia.so.${PV}
	usr/lib64/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib64/libcuda.so.${PV}
	usr/lib64/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib64/xorg/modules/drivers/nvidia_drv.so
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

QA_WX_LOAD_x86="usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/libXvMCNVIDIA.a
	usr/lib64/libXvMCNVIDIA.so.${PV}"

QA_WX_LOAD_amd64="usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}"

QA_SONAME_x86="usr/lib/libnvidia-compiler.so.${PV}"

QA_SONAME_amd64="usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib32/libnvidia-compiler.so.${PV}"

QA_DT_HASH_amd64="usr/lib32/libcuda.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib64/libcuda.so.${PV}
	usr/lib64/libnvidia-cfg.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/libnvidia-ml.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/xorg/modules/drivers/nvidia_drv.so
	usr/lib64/libvdpau_nvidia.so.${PV}
	usr/lib64/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib64/libnvcuvid.so.${PV}
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

QA_DT_HASH_x86="usr/lib/libcuda.so.${PV}
	usr/lib/libnvidia-cfg.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/libnvidia-ml.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/xorg/modules/drivers/nvidia_drv.so
	usr/lib/libXvMCNVIDIA.so.${PV}
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libnvcuvid.so.${PV}
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

S=${WORKDIR}/

pkg_pretend() {

	if use amd64 && has_multilib_profile && \
		[ "${DEFAULT_ABI}" != "amd64" ]; then
		eerror "This ebuild doesn't currently support changing your default ABI"
		die "Unexpected \${DEFAULT_ABI} = ${DEFAULT_ABI}"
	fi

	# Kernel features/options to check for
	CONFIG_CHECK="~ZONE_DMA ~MTRR ~SYSVIPC ~!LOCKDEP"
	use x86 && CONFIG_CHECK+=" ~HIGHMEM"

	# Now do the above checks
	use kernel_linux && check_extra_config
}

pkg_setup() {
	# try to turn off distcc and ccache for people that have a problem with it
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	if use kernel_linux; then
		linux-mod_pkg_setup
		MODULE_NAMES="nvidia(video:${S}/kernel)"
		BUILD_PARAMS="IGNORE_CC_MISMATCH=yes V=1 SYSSRC=${KV_DIR} \
		SYSOUT=${KV_OUT_DIR} CC=$(tc-getBUILD_CC)"
		# linux-mod_src_compile calls set_arch_to_kernel, which
		# sets the ARCH to x86 but NVIDIA's wrapping Makefile
		# expects x86_64 or i386 and then converts it to x86
		# later on in the build process
		BUILD_FIXES="ARCH=$(uname -m | sed -e 's/i.86/i386/')"
	fi

	# Since Nvidia ships 3 different series of drivers, we need to give the user
	# some kind of guidance as to what version they should install. This tries
	# to point the user in the right direction but can't be perfect. check
	# nvidia-driver.eclass
	nvidia-driver-check-warning

	# set variables to where files are in the package structure
	if use kernel_FreeBSD; then
		use x86-fbsd   && S="${WORKDIR}/${X86_FBSD_NV_PACKAGE}"
		use amd64-fbsd && S="${WORKDIR}/${AMD64_FBSD_NV_PACKAGE}"
		NV_DOC="${S}/doc"
		NV_OBJ="${S}/obj"
		NV_SRC="${S}/src"
		NV_MAN="${S}/x11/man"
		NV_X11="${S}/obj"
		NV_SOVER=1
	elif use kernel_linux; then
		NV_DOC="${S}"
		NV_OBJ="${S}"
		NV_SRC="${S}/kernel"
		NV_MAN="${S}"
		NV_X11="${S}"
		NV_SOVER=${PV}
	else
		die "Could not determine proper NVIDIA package"
	fi
}

src_unpack() {
	if ! use kernel_FreeBSD; then
		cd "${S}"
		unpack_makeself
	else
		unpack ${A}
	fi
}

src_prepare() {
	# Please add a brief description for every added patch

	if use kernel_linux; then
		if kernel_is lt 2 6 9 ; then
			eerror "You must build this against 2.6.9 or higher kernels."
		fi

		# If greater than 2.6.5 use M= instead of SUBDIR=
		convert_to_m "${NV_SRC}"/Makefile.kbuild
	fi
	cat <<- EOF > "${S}"/nvidia.icd
		/usr/$(get_libdir)/libcuda.so
	EOF

	# Allow user patches so they can support RC kernels and whatever else
	epatch_user
}

src_compile() {
	# This is already the default on Linux, as there's no toplevel Makefile, but
	# on FreeBSD there's one and triggers the kernel module build, as we install
	# it by itself, pass this.

	cd "${NV_SRC}"
	if use kernel_FreeBSD; then
		MAKE="$(get_bmake)" CFLAGS="-Wno-sign-compare" emake CC="$(tc-getCC)" \
			LD="$(tc-getLD)" LDFLAGS="$(raw-ldflags)" || die
	elif use kernel_linux; then
		linux-mod_src_compile
	fi
}

# Install nvidia library:
# the first parameter is the library to install
# the second parameter is the provided soversion
# the third parameter is the target directory if its not /usr/lib
donvidia() {
	# Full path to library minus SOVER
	MY_LIB="$1"

	# SOVER to use
	MY_SOVER="$2"

	# Where to install
	MY_DEST="$3"

	if [[ -z "${MY_DEST}" ]]; then
		MY_DEST="/usr/$(get_libdir)"
		action="dolib.so"
	else
		exeinto ${MY_DEST}
		action="doexe"
	fi

	# Get just the library name
	libname=$(basename $1)

	# Install the library with the correct SOVER
	${action} ${MY_LIB}.${MY_SOVER} || \
		die "failed to install ${libname}"

	# If SOVER wasn't 1, then we need to create a .1 symlink
	if [[ "${MY_SOVER}" != "1" ]]; then
		dosym ${libname}.${MY_SOVER} \
			${MY_DEST}/${libname}.1 || \
			die "failed to create ${libname} symlink"
	fi

	# Always create the symlink from the raw lib to the .1
	dosym ${libname}.1 \
		${MY_DEST}/${libname} || \
		die "failed to create ${libname} symlink"
}

src_install() {
	if use kernel_linux; then
		linux-mod_src_install

		VIDEOGROUP="$(egetent group video | cut -d ':' -f 3)"
		if [ -z "$VIDEOGROUP" ]; then
			eerror "Failed to determine the video group gid."
			die "Failed to determine the video group gid."
		fi

		# Add the aliases
		[ -f "${FILESDIR}/nvidia-169.07" ] || die "nvidia missing in FILESDIR"
		sed -e 's:PACKAGE:'${PF}':g' \
			-e 's:VIDEOGID:'${VIDEOGROUP}':' "${FILESDIR}"/nvidia-169.07 > \
			"${WORKDIR}"/nvidia
		insinto /etc/modprobe.d
		newins "${WORKDIR}"/nvidia nvidia.conf || die

		# Ensures that our device nodes are created when not using X
		exeinto /lib/udev
		doexe "${FILESDIR}"/nvidia-udev.sh

		insinto /lib/udev/rules.d
		newins "${FILESDIR}"/nvidia.udev-rule 99-nvidia.rules
	elif use kernel_FreeBSD; then
		if use x86-fbsd; then
			insinto /boot/modules
			doins "${S}/src/nvidia.kld" || die
		fi

		exeinto /boot/modules
		doexe "${S}/src/nvidia.ko" || die
	fi

	# NVIDIA kernel <-> userspace driver config lib
	donvidia ${NV_OBJ}/libnvidia-cfg.so ${NV_SOVER}

	if use kernel_linux; then
		# NVIDIA video decode <-> CUDA
		donvidia ${NV_OBJ}/libnvcuvid.so ${NV_SOVER}
	fi

	# Xorg DDX driver
	insinto /usr/$(get_libdir)/xorg/modules/drivers
	doins ${NV_X11}/nvidia_drv.so || die "failed to install nvidia_drv.so"

	# Xorg GLX driver
	donvidia ${NV_X11}/libglx.so ${NV_SOVER} \
		/usr/$(get_libdir)/opengl/nvidia/extensions

	# XvMC driver
	dolib.a ${NV_X11}/libXvMCNVIDIA.a || \
		die "failed to install libXvMCNVIDIA.so"
	donvidia ${NV_X11}/libXvMCNVIDIA.so ${NV_SOVER}
	dosym libXvMCNVIDIA.so.${NV_SOVER} \
		/usr/$(get_libdir)/libXvMCNVIDIA_dynamic.so.1 || \
		die "failed to create libXvMCNVIDIA_dynamic.so symlink"

	# OpenCL ICD for NVIDIA
	if use kernel_linux; then
		insinto /etc/OpenCL/vendors
		doins nvidia.icd
	fi

	# Documentation
	dohtml ${NV_DOC}/html/*
	if use kernel_FreeBSD; then
		dodoc "${NV_DOC}/README"
		doman "${NV_MAN}/nvidia-xconfig.1"
		doman "${NV_MAN}/nvidia-settings.1"
		dohtml "${NV_DOC}/html/*"
	else
		# Docs
		newdoc "${NV_DOC}/README.txt" README
		dodoc "${NV_DOC}/NVIDIA_Changelog"
		doman "${NV_MAN}/nvidia-smi.1.gz"
		doman "${NV_MAN}/nvidia-xconfig.1.gz"
		doman "${NV_MAN}/nvidia-settings.1.gz"
		doman "${NV_MAN}/nvidia-cuda-proxy-control.1.gz"
		dohtml "${NV_DOC}/html/*"
	fi

	# Helper Apps
	exeinto /opt/bin/
	doexe ${NV_OBJ}/nvidia-xconfig || die

	if use kernel_linux ; then
		doexe ${NV_OBJ}/nvidia-debugdump || die
		doexe ${NV_OBJ}/nvidia-cuda-proxy-control || die
		doexe ${NV_OBJ}/nvidia-cuda-proxy-server || die
		doexe ${NV_OBJ}/nvidia-smi || die
		newinitd "${FILESDIR}/nvidia-smi.init" nvidia-smi
	fi

	if use tools; then
		doexe ${NV_OBJ}/nvidia-settings || die
	fi

	exeinto /usr/bin/
	doexe ${NV_OBJ}/nvidia-bug-report.sh || die

	# Desktop entries for nvidia-settings
	if use tools ; then
		newicon ${NV_OBJ}/nvidia-settings.png nvidia-driver-settings.png
		domenu "${FILESDIR}"/nvidia-driver-settings.desktop
		insinto /etc/xdg/autostart
		doins "${FILESDIR}"/nvidia-autostart.desktop
	fi


	doenvd "${FILESDIR}"/50nvidia-prelink-blacklist

	if has_multilib_profile && use multilib ; then
		local OABI=${ABI}
		for ABI in $(get_install_abis) ; do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	is_final_abi || die "failed to iterate through all ABIs"
}

src_install-libs() {
	local inslibdir=$(get_libdir)
	local GL_ROOT="/usr/$(get_libdir)/opengl/nvidia/lib"
	local CL_ROOT="/usr/$(get_libdir)/OpenCL/vendors/nvidia"
	local libdir=${NV_OBJ}

	if use kernel_linux && has_multilib_profile && \
			[[ ${ABI} == "x86" ]] ; then
		libdir=${NV_OBJ}/32
	fi

	# The GLX libraries
	donvidia ${libdir}/libGL.so ${NV_SOVER} ${GL_ROOT}
	donvidia ${libdir}/libnvidia-glcore.so ${NV_SOVER}
	if use kernel_FreeBSD; then
		donvidia ${libdir}/libnvidia-tls.so ${NV_SOVER} ${GL_ROOT}
	else
		donvidia ${libdir}/tls/libnvidia-tls.so ${NV_SOVER} ${GL_ROOT}
	fi

	# VDPAU
	donvidia ${libdir}/libvdpau_nvidia.so ${NV_SOVER}

	# NVIDIA monitoring library
	if use kernel_linux ; then
		donvidia ${libdir}/libnvidia-ml.so ${NV_SOVER}
	fi

	# CUDA & OpenCL
	if use kernel_linux; then
		donvidia${libdir}/libcuda.so ${NV_SOVER}
		donvidia${libdir}/libnvidia-compiler.so ${NV_SOVER}
		donvidia ${libdir}/libOpenCL.so 1.0.0 ${CL_ROOT}
	fi
}

pkg_preinst() {
	use kernel_linux && linux-mod_pkg_preinst

	# Clean the dynamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d "${ROOT}"/usr/lib/opengl/nvidia ] ; then
		rm -rf "${ROOT}"/usr/lib/opengl/nvidia/*
	fi
	# Make sure we nuke the old nvidia-glx's env.d file
	if [ -e "${ROOT}"/etc/env.d/09nvidia ] ; then
		rm -f "${ROOT}"/etc/env.d/09nvidia
	fi
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst

	# Switch to the nvidia implementation
	"${ROOT}"/usr/bin/eselect opengl set --use-old nvidia
	"${ROOT}"/usr/bin/eselect opencl set --use-old nvidia

	elog "You must be in the video group to use the NVIDIA device"
	elog "For more info, read the docs at"
	elog "http://www.gentoo.org/doc/en/nvidia-guide.xml#doc_chap3_sect6"
	elog
	elog "This ebuild installs a kernel module and X driver. Both must"
	elog "match explicitly in their version. This means, if you restart"
	elog "X, you must modprobe -r nvidia before starting it back up"
	elog
	elog "To use the NVIDIA GLX, run \"eselect opengl set nvidia\""
	elog
	elog "To use the NVIDIA CUDA/OpenCL, run \"eselect opencl set nvidia\""
	elog
	elog "NVIDIA has requested that any bug reports submitted have the"
	elog "output of /opt/bin/nvidia-bug-report.sh included."
	elog
	if ! use tools; then
		elog "USE=tools controls whether the nvidia-settings application"
		elog "is installed. If you would like to use it, enable that"
		elog "flag and re-emerge this ebuild. Optionally you can install"
		elog "media-video/nvidia-settings"
	fi
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

pkg_postrm() {
	use kernel_linux && linux-mod_pkg_postrm
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}
