# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/banshee/banshee-1.0.0.ebuild,v 1.2 2008/06/11 15:29:59 loki_val Exp $

EAPI=1

inherit eutils mono gnome2

GVER=0.10.3

DESCRIPTION="Import, organize, play, and share your music using a simple and powerful interface."
HOMEPAGE="http://banshee-project.org"
SRC_URI="http://download.banshee-project.org/${PN}/${PN}-1-${PV}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aac +boo +daap doc +encode +flac +ipod +mad +mtp +podcast test +vorbis"

RDEPEND=">=dev-lang/mono-1.2.4
	>=dev-dotnet/gtk-sharp-2.10
	>=dev-dotnet/gconf-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	>=media-libs/gst-plugins-bad-${GVER}
	>=media-libs/gst-plugins-good-${GVER}
	>=media-libs/gst-plugins-ugly-${GVER}
	>=media-plugins/gst-plugins-alsa-${GVER}
	>=media-plugins/gst-plugins-gnomevfs-${GVER}
	>=media-plugins/gst-plugins-gconf-${GVER}
	>=media-plugins/gst-plugins-cdparanoia-${GVER}
	=media-libs/musicbrainz-2*
	dev-dotnet/dbus-glib-sharp
	dev-dotnet/mono-addins
	dev-dotnet/taglib-sharp
	>=dev-db/sqlite-3.4
	aac? (
		>=media-plugins/gst-plugins-faad-${GVER}
	)
	boo? (
		>=dev-lang/boo-0.8.1
	)
	daap? (
	 	>=dev-dotnet/mono-zeroconf-0.7.3
	)
	doc? (
		dev-util/monodoc
	)
	encode? (
		>=media-plugins/gst-plugins-lame-${GVER}
		>=media-plugins/gst-plugins-taglib-${GVER}
	)
	flac? (
		>=media-plugins/gst-plugins-flac-${GVER}
	)
	ipod? (
		>=dev-dotnet/ipod-sharp-0.8.0
	)
	mad? (
		>=media-plugins/gst-plugins-mad-${GVER}
	)
	mtp? (
		>=media-libs/libmtp-0.2.0
	)
	vorbis? (
		>=media-plugins/gst-plugins-ogg-${GVER}
		>=media-plugins/gst-plugins-vorbis-${GVER}
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

S=${WORKDIR}/${PN}-1-${PV}

pkg_setup() {
	G2CONF="${G2CONF} \
		$(use_enable doc docs) \
		$(use_enable mtp) \
		$(use_enable daap) \
		$(use_enable ipod) \
		$(use_enable podcast) \
		$(use_enable test tests)"

	MAKEOPTS="${MAKEOPTS} -j1"
}
