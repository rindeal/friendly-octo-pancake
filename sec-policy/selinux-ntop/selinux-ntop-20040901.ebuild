# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntop/selinux-ntop-20040901.ebuild,v 1.2 2004/09/20 01:55:47 pebenito Exp $

TEFILES="ntop.te"
FCFILES="ntop.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for ntop"

KEYWORDS="x86 ppc sparc amd64"

