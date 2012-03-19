# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vcs-snapshot.eclass,v 1.2 2012/03/19 08:52:49 mgorny Exp $

# @ECLASS: vcs-snapshot.eclass
# @MAINTAINER:
# mgorny@gentoo.org
# @BLURB: support eclass for VCS (github, bitbucket, gitweb) snapshots
# @DESCRIPTION:
# This eclass provides a convenience src_unpack() which does support
# working with snapshots generated by various VCS-es. It unpacks those
# to ${S} rather than the original directory containing commit id.
#
# Note that this eclass handles only unpacking. You need to specify
# SRC_URI yourself, and call any autoreconfiguration as necessary.
# The example does that using autotools-utils eclass.
#
# Right now, the eclass was tested with github, bitbucket and gitweb
# snapshots. Feel free to report snapshotting services which aren't
# working.
# @EXAMPLE:
#
# @CODE
# EAPI=4
# AUTOTOOLS_AUTORECONF=1
# inherit autotools-utils vcs-snapshot
#
# SRC_URI="http://github.com/example/${PN}/tarball/v${PV} -> ${P}.tar.gz"
# @CODE

case ${EAPI:-0} in
	0|1) die "EAPI ${EAPI} unsupported.";; # default(), SRC_URI arrows
	2|3|4) ;;
	*) die "vcs-snapshot.eclass API in EAPI ${EAPI} not yet established."
esac

EXPORT_FUNCTIONS src_unpack

vcs-snapshot_src_unpack() {
	default

	# github, bitbucket: username-projectname-hash
	# gitweb: projectname-tagname-hash
	mv *-*-[0-9a-f]*[0-9a-f]/ "${S}" || die
}
