# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.3.0-r2.ebuild,v 1.1 2004/03/10 22:02:23 stuart Exp $

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise
	>=net-misc/nxssh-1.3.0
	>=net-misc/nxproxy-1.3.0"

MY_PV="${PV}-25"

SRC_URI="http://www.nomachine.com/download/nxserver-personal/1.3.0/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
