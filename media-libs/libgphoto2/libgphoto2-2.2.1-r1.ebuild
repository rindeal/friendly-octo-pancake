# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.2.1-r1.ebuild,v 1.21 2007/03/28 11:48:23 zzam Exp $

inherit libtool eutils autotools

DESCRIPTION="Library that implements support for numerous digital cameras"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="nls doc exif hal"
RESTRICT="test confcache"

RDEPEND="
	>=dev-libs/libusb-0.1.8
	exif? ( >=media-libs/libexif-0.5.9 )
	hal? ( >=sys-apps/hal-0.5 )
	sys-devel/libtool"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc
		=app-text/docbook-sgml-dtd-4.2*
	)"

# By default, drivers for all supported cameras will be compiled.
# If you want to only compile for specific camera(s), set CAMERAS
# environment to a space-separated list (no commas) of drivers that
# you want to build.
IUSE_CAMERAS="adc65 agfa-cl20 aox barbie canon casio clicksmart310
	digigr8 digita dimera directory enigma13 fuji gsmart300 hp215 iclick jamcam
	jd11 kodak konica largan lg_gsm mars minolta mustek panasonic pccam300
	pccam600 polaroid ptp2 ricoh samsung sierra sipix smal sonix sonydscf1
	sonydscf55 soundvision spca50x sq905 stv0674 stv0680 sx330z template
	toshiba"

pkg_setup() {
	if [[ -z "${CAMERAS}" ]] ; then
		ewarn "All camera drivers will be built since you did not specify"
		ewarn "via the CAMERAS variable what camera you use."
		ewarn "libgphoto2 supports: all ${IUSE_CAMERAS}"
	fi
	echo

	enewgroup plugdev || die "Error creating plugdev group"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.2-norpm.patch
	epatch ${FILESDIR}/${PN}-2.2.0-includes.patch
	epatch ${FILESDIR}/libgphoto-2.2.1-new-dbus-api.patch

	# bug #139534: already merged into upstream SVN
	epatch ${FILESDIR}/${P}-ngettext.patch

	# bug #153471: create udev-rules for udev >= 0.98
	epatch ${FILESDIR}/${P}-backported-udev-fixes.diff

	# make default group 'plugdev', not camera
	sed -e 's:=camera:=plugdev:' -i packaging/linux-hotplug/usbcam.group

	# fix typo for apidoc
	# originally in : libgphoto2_port/m4/gp-documentation.m4
	# but we save on running autoconf again by just patching configure
	sed -i -e 's:apidocdir\}:apidocdir:g' \
		configure \
		libgphoto2_port/configure
}

src_compile() {
	local cameras
	local cam
	for cam in ${CAMERAS} ; do
		has ${cam} ${IUSE_CAMERAS} && cameras="${cameras},${cam}"
	done
	[[ -z "${cameras}" ]] \
		&& cameras="all" \
		|| cameras="${cameras:1}"
	einfo $cameras

	elibtoolize

	local myconf

	use exif \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	econf \
		--with-drivers=${cameras} \
		--with-doc-dir=/usr/share/doc/${PF} \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-hotplug-doc-dir=/usr/share/doc/${PF}/hotplug \
		$(use_enable nls) \
		$(use_enable doc docs) \
		${myconf} || die "econf failed"

	# documentation breaks with -j1
	emake -j1 apidocdir=/usr/share/doc/${PF}/api || die "make failed"
}

src_install() {
	make DESTDIR=${D} install \
		apidocdir=/usr/share/doc/${PF}/api || die "install failed"

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	if use kernel_linux; then
		insinto /etc/hotplug/usb
		newins ${S}/packaging/linux-hotplug/usbcam.group usbcam
		chmod +x ${D}/etc/hotplug/usb/usbcam
	fi

	if [[ -x ${D}/usr/$(get_libdir)/libgphoto2/print-camera-list ]]; then
		# Let print-camera-list find libgphoto2.so
		export LD_LIBRARY_PATH="${D}/usr/$(get_libdir)"
		# Let libgphoto2 find its camera-modules
		export CAMLIBS="${D}/usr/$(get_libdir)/libgphoto2/${PV}"

		HOTPLUG_USERMAP="/etc/hotplug/usb/usbcam-gphoto2.usermap"
		HAL_FDI="/usr/share/hal/fdi/information/10freedesktop/10-camera-libgphoto2.fdi"
		UDEV_RULES="/etc/udev/rules.d/99-libgphoto2.rules"

		if use kernel_linux; then
			einfo "Generating usbcam-gphoto2.usermap ..."
			echo "# !!! DO NOT EDIT THIS FILE !!! This file is automatically generated." > ${D}/${HOTPLUG_USERMAP}
			echo "# Put your custom entries in /etc/hotplug/usb/usbcam.usermap" >> ${D}/${HOTPLUG_USERMAP}
			${D}/usr/$(get_libdir)/libgphoto2/print-camera-list usb-usermap >> ${D}/${HOTPLUG_USERMAP} \
				|| die "failed to create usb-usermap"
		fi

		if use hal; then
			einfo "Generating HAL FDI files ..."
			mkdir -p ${D}/${HAL_FDI%/*}
			${D}/usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi >> ${D}/${HAL_FDI} \
				|| die "failed to create hal-fdi"
		fi

		einfo "Generating UDEV-rules ..."
		mkdir -p ${D}/${UDEV_RULES%/*}
		${D}/usr/$(get_libdir)/libgphoto2/print-camera-list udev-rules-0.98 >> ${D}/${UDEV_RULES} \
			|| die "failed to create udev-rules"
		exeinto /lib/udev
		doexe ${S}/packaging/generic/check_ptp_camera
	else
		eerror "Unable to find print-camera-list"
		eerror "and therefore unable to generate hotplug usermap or HAL FDI files."
		eerror "You will have to manually generate it by running:"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list usb-usermap > ${HOTPLUG_USERMAP}"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi > ${HAL_FDI}"
	fi

}

pkg_postinst() {
	elog "Don't forget to add yourself to the plugdev group "
	elog "if you want to be able to access your camera."
}
