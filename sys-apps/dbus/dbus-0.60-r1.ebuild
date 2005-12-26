# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.60-r1.ebuild,v 1.2 2005/12/26 15:02:36 kloeri Exp $

inherit eutils mono python multilib debug qt3

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 AFL-2.1 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="X doc gcj gtk mono python qt xml2"

RDEPEND=">=dev-libs/glib-2.6
	X? ( || ( ( x11-libs/libXt x11-libs/libX11 ) virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.4 )
	mono? ( >=dev-lang/mono-0.95 )
	python? ( >=dev-lang/python-2.4 >=dev-python/pyrex-0.9.3-r2 )
	qt? ( $(qt_min_version 3.3) )
	xml2? ( >=dev-libs/libxml2-2.6.21 )
	!xml2? ( dev-libs/expat )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (	app-doc/doxygen
		app-text/xmlto
		mono? ( >=dev-util/monodoc-0.16
		>=dev-util/mono-tools-1.1.9 ) )"

pkg_setup() {
	if use gcj && ! built_with_use sys-devel/gcc gcj; then
		eerror "To build the Java bindings for dbus, you must re-build gcc"
		eerror "with the 'gcj' USE flag. Add 'gcj' to USE and re-emerge gcc."
		die "gcc needs gcj support to use the java bindings"
	fi

	PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig"
}

src_compile() {
	local myconf=""

	# Choose which xml library to use
	if use xml2; then
		myconf="${myconf} --with-xml=libxml"
	else
		myconf="${myconf} --with-xml=expat"
	fi

	# Only enable mono-docs if both mono and doc is defined
	use mono && myconf="${myconf} $(use_enable doc mono-docs)"

	if use qt; then
		myconf="${myconf} --enable-qt=${QTDIR} QT_MOC=${QTDIR}/bin/moc"
	else
		myconf="${myconf} --disable-qt"
	fi

	econf \
		$(use_with X x) \
		$(use_enable gtk) \
		$(use_enable python) \
		$(use_enable mono) \
		$(use_enable kernel_linux dnotify) \
		$(use_enable gcj) \
		$(use_enable debug verbose-mode) \
		$(use_enable debug checks) \
		$(use_enable debug asserts) \
		--enable-glib \
		--with-system-pid-file=/var/run/dbus.pid \
		--with-system-socket=/var/run/dbus/system_bus_socket \
		--with-session-socket-dir=/tmp \
		--with-dbus-user=messagebus \
		$(use_enable doc doxygen-docs) \
		--disable-xml-docs \
		${myconf} \
		|| die "econf failed"

	# Don't build the mono examples, they require gtk-sharp
	touch ${S}/mono/example/{bus-listener,echo-{server,client}}.exe

	# this gets around a lib64 sandbox bug. note that this addpredict is
	# added automatically by sandbox.c for lib.
	addpredict /usr/lib64/python2.4/
	addpredict /usr/lib64/python2.3/
	addpredict /usr/lib64/python2.2/
	addpredict /usr/lib64/python2.1/

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Backwards compatibility for old stuff
	# we can remove this when dbi (plural of dbus)
	# <0.30 aren't in the tree
	dosym /usr/bin/dbus-daemon /usr/bin/dbus-daemon-1

	# initscript
	doinitd ${FILESDIR}/dbus

	# dbus X session script (#77504)
	# FIXME : turns out to only work for GDM, better solution needed
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe ${FILESDIR}/30-dbus

	# needs to exist for the system socket
	keepdir /var/run/dbus

	keepdir /usr/lib/dbus-1.0/services
	keepdir /usr/share/dbus-1/services

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO
	if use doc; then
		dohtml doc/*html
	fi
}

pkg_preinst() {
	enewgroup messagebus || die "Problem adding messagebus group"
	enewuser messagebus -1 "-1" /dev/null messagebus || die "Problem adding messagebus user"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/dbus
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/dbus

	einfo "To start the DBUS system-wide messagebus by default"
	einfo "you should add it to the default runlevel :"
	einfo "\`rc-update add dbus default\`"

	ewarn
	ewarn "There have been major ABI/API changes.  This version will not"
	ewarn "work with other packages.  We are not responsible for a broken"
	ewarn "system. The sonames have changed, so you must run a revdep-rebuild"
	ewarn "afterwards to ensure that the packages dont die."
	ewarn
}
