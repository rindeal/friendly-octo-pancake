# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlimages/camlimages-2.20.ebuild,v 1.4 2006/02/04 13:36:17 mattam Exp $

inherit findlib eutils

IUSE="gtk opengl"

DESCRIPTION="An image manipulation library for ocaml"
HOMEPAGE="http://pauillac.inria.fr/camlimages/"
SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/bazar-ocaml/${P/20/2}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86 ppc"

DEPEND=">=dev-lang/ocaml-3.08"

MY_S="${WORKDIR}/${P/20/2}"

src_unpack() {
	unpack ${A}
	cd ${MY_S}
	if has_version ">=dev-lang/ocaml-3.09";
	then
		epatch ${FILESDIR}/${P}-ocaml-3.09.diff
	fi
}

src_compile() {
	local myconf

	cd ${MY_S}

	if !(use gtk);
	then
		myconf="--with-lablgtk=/dev/null --with-lablgtk2=/dev/null"
	fi

	if !(use opengl);
	then
		myconf="--with-lablgl=/dev/null"
	fi

	econf || die
	emake -j1 || die
	emake -j1 opt || die
}

src_test() {
	cd ${MY_S}/test
	make
	./test
	./test.byt
}

src_install() {
	# Use findlib to install properly, especially to avoid
	# the shared library mess
	findlib_src_preinst
	mkdir ${D}/tmp
	cd ${MY_S}
	make CAMLDIR=${D}/tmp \
		LIBDIR=${D}/tmp \
		DESTDIR=${D}/tmp \
		install || die
	sed -e "s/VERSION/${PV}/" ${FILESDIR}/META > ${D}/tmp/META

	ocamlfind install camlimages ${D}/tmp/*
	rm -rf ${D}/tmp
}
