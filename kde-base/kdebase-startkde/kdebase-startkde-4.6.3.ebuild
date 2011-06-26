# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-4.6.3.ebuild,v 1.6 2011/06/26 01:54:29 ranger Exp $

EAPI=4

KMNAME="kdebase-workspace"
KMNOMODULE="true"
inherit kde4-meta multilib prefix

DESCRIPTION="Startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

# The KDE apps called from the startkde script.
# These provide the most minimal KDE desktop.
RDEPEND="
	$(add_kdebase_dep kcminit)
	$(add_kdebase_dep kdebase-runtime-meta)
	$(add_kdebase_dep kdebase-wallpapers)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep knotify)
	$(add_kdebase_dep kreadconfig)
	$(add_kdebase_dep krunner)
	$(add_kdebase_dep ksmserver)
	$(add_kdebase_dep ksplash)
	$(add_kdebase_dep kstartupconfig)
	$(add_kdebase_dep kwin)
	$(add_kdebase_dep phonon-kde)
	$(add_kdebase_dep plasma-apps)
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep systemsettings)
	x11-apps/mkfontdir
	x11-apps/xmessage
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xrdb
	x11-apps/xsetroot
	x11-apps/xset
"

KMEXTRACTONLY="
	ConfigureChecks.cmake
	kdm/
	startkde.cmake
"

PATCHES=("${FILESDIR}/gentoo-startkde4-3.patch")

src_prepare() {
	kde4-meta_src_prepare

	# Sort the LDFLAGS out if necessary
	sed -e "s#@REPLACE_LDFLAGS@##" \
		-i startkde.cmake || die "sed for LDPATH failed"

	# Complete LDPATH
	sed -e "s#@REPLACE_LIBDIR@#$(get_libdir)#" \
		-i startkde.cmake || die "Sed for REPLACE_LIBDIR failed."
	# Now fix the prefix
	sed -e "s#@REPLACE_PREFIX@#/usr#" \
		-i startkde.cmake || die "Sed for REPLACE_PREFIX failed."
	# ... and fix ${EPREFIX}
	eprefixify startkde.cmake
}

src_install() {
	kde4-meta_src_install

	# startup and shutdown scripts
	insinto "/etc/kde/startup"
	doins "${FILESDIR}/agent-startup.sh"

	insinto "/etc/kde/shutdown"
	doins "${FILESDIR}/agent-shutdown.sh"

	# x11 session script
	cp "${FILESDIR}/sessionfile" "${T}/KDE-4" || die
	cat <<-EOF >> "${T}/KDE-4"
	exec "${EPREFIX}/usr/bin/startkde"
	EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/KDE-4"

	# freedesktop compliant session script
	sed -e "s:\${KDE4_BIN_INSTALL_DIR}:${EPREFIX}/usr/bin:g;s:Name=KDE:Name=KDE $(get_kde_version):" \
		"${S}/kdm/kfrontend/sessions/kde-plasma.desktop.cmake" > "${T}/KDE-4.desktop"
	insinto /usr/share/xsessions
	doins "${T}/KDE-4.desktop"
}

pkg_postinst () {
	kde4-meta_pkg_postinst

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${EPREFIX}/etc/kde/startup/agent-startup.sh and"
	elog "${EPREFIX}/etc/kde/shutdown/agent-shutdown.sh"
	echo
	elog "The name of the session script has changed."
	elog "If you currently have XSESSION=\"kde-$(get_kde_version)\" in your"
	elog "configuration files, you will need to change it to"
	elog "XSESSION=\"KDE-4\""
}
