# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-1.3.0.53-r1.ebuild,v 1.7 2007/07/12 05:34:47 mr_bones_ Exp $

inherit eutils qt3

#If you want to know when this package will be marked stable please see the Changelog
RESTRICT="mirror strip"
AVATARV="1.0"
DESCRIPTION="${PN} is a P2P-VoiceIP client."
MY_PN=${PN}
HOMEPAGE="http://www.skype.com/"
SRC_URI="http://dev.gentoo.org/~humpback/skype-avatars-${AVATARV}.tgz
		!static? ( http://download.skype.com/linux/${MY_PN}-${PV}-generic.tar.bz2 )
		static? (
		http://download.skype.com/linux/${MY_PN}_staticQT-${PV}-generic.tar.bz2 )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static cjk"
DEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat
		!static? ( >=app-emulation/emul-linux-x86-qtlibs-1.1 ) )
	x86? ( >=sys-libs/glibc-2.3.2
		>=media-libs/alsa-lib-1.0.11
		virtual/libstdc++
		!static? ( $(qt_min_version 3.2) ) )"
RDEPEND="${DEPEND}
	>=sys-apps/dbus-0.23.4"

QA_EXECSTACK_x86="opt/skype/skype"
QA_EXECSTACK_amd64="opt/skype/skype"

src_unpack() {
	if use static;
	then
		unpack ${MY_PN}_staticQT-${PV}-generic.tar.bz2
	else
		if use cjk;
		then
			ewarn "If you use scim to have Multi-byte character's in QT"
			ewarn "applications you will not be able to input cjk. This is a"
			ewarn "know upstream issue"
			sleep 5
		fi
		unpack ${MY_PN}-${PV}-generic.tar.bz2
	fi
	cd ${P}
	unpack skype-avatars-${AVATARV}.tgz

}

src_install() {
	## Install the wrapper script
	#mv skype skype
	#cp ${FILESDIR}/sDaemonWrapper-r1 skype

	# remove mprotect() restrictions for PaX usage - see Bug 100507
	[[ -x /sbin/chpax ]] && /sbin/chpax -m skype

	dodir /opt/${PN}
	exeopts -m0755
	exeinto /opt/${PN}
	doexe skype
	doexe ${FILESDIR}/skype.sh
	dosym /opt/skype/skype.sh /usr/bin/skype

	doexe skype-callto-handler
	insinto /opt/${PN}/sound
	doins sound/*.wav

	insinto /opt/${PN}/lang
	doins lang/*.qm
	#Skype still shows ALL languagues no matter what were installed
	#for i in ${LINGUAS}; do
	#	if [ -f lang/${PN}_${i}.qm ]; then
	#		doins lang/${PN}_${i}.qm
	#	fi;
	#done;
	insinto /etc/dbus-1/system.d
	newins ${FILESDIR}/skype.debus.config skype.conf

	insinto /opt/${PN}/avatars
	doins avatars/*.jpg

	insinto /opt/${PN}
	for SIZE in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		newins ${S}/icons/${PN}_${SIZE}_32.png ${PN}.png
	done

	# The skype icon doesn't show up in gnome for some reason
	# Putting the icon in /usr/share/pixmaps seems to solve it
	insinto /usr/share/pixmaps
	newins ${S}/icons/${PN}_48_32.png ${PN}.png

	fowners root:audio /opt/skype/skype
	fowners root:audio /opt/skype/skype-callto-handler

	insinto /usr/share/applications/
	doins skype.desktop

	dodir /usr/bin/
	# Install the Documentation
	dodoc README LICENSE

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
}

pkg_postinst() {
	einfo "If you have sound problems please visit: "
	einfo "http://forum.skype.com/bb/viewtopic.php?t=4489"
	einfo "These kernel options are reported to help"
	einfo "Processor type and features --->"
	einfo "-- Preemption Model (Preemptible Kernel (Low-Latency Desktop))"
	einfo "-- Timer frequency (250 HZ)"
	ewarn ""
	ewarn "This release no longer uses the old wrapper because skype now uses
	ALSA"
	ewarn ""

}
