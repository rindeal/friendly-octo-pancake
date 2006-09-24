# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gpl/gnat-gpl-3.4.6.2006.ebuild,v 1.4 2006/09/24 16:00:11 dholm Exp $

inherit gnatbuild

DESCRIPTION="GNAT Ada Compiler - AdaCore GPL version"
HOMEPAGE="https://libre2.adacore.com/"
LICENSE="GPL-2"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${GCCVER}/gcc-core-${GCCVER}.tar.bz2
	http://www.adaic.org/standards/05rm/RM-05-Html.zip
	http://dev.gentoo.org/~george/src/${PN}-3.4.6.1-src.tar.bz2
	http://dev.gentoo.org/~george/src/${PN}-gcc-3.4.6.1.diff.bz2
	x86?   ( http://dev.gentoo.org/~george/src/gnatboot-${BOOT_SLOT}-i386.tar.bz2 )
	ppc?   ( http://dev.gentoo.org/~george/src/gnatboot-${BOOT_SLOT}-ppc.tar.bz2 )
	amd64? ( http://dev.gentoo.org/~george/src/gnatboot-${BOOT_SLOT}-amd64-r2.tar.bz2 )"
# ${BOOT_SLOT} and ${GCCVER} are defined in gnatbuild.eclass and depend 
# only on $PV, so should be safe to use in DEPEND/SRC_URI

KEYWORDS="~amd64 ~ppc ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""

GNATSOURCE="${WORKDIR}/${PN}-2006-src"

src_unpack() {
	gnatbuild_src_unpack base_unpack

	# prep gcc sources for Ada
	mv "${GNATSOURCE}/src/ada" "${S}/gcc"
	cd "${S}"
	epatch ${WORKDIR}/${PN}-gcc-3.4.6.1.diff

	gnatbuild_src_unpack common_prep

	# one of the converted gcc->gnatgcc in common_prep needs to stay gcc in
	# fact in this version
	sed -i -e 's:(Last3 = "gnatgcc"):(Last3 = "gcc"):' "${S}"/gcc/ada/makegpr.adb
	# reverting similar conversion in comment - line too long
	sed -i -e 's:"gnatgcc":"gcc":' "${S}"/gcc/ada/osint.ads
}

src_install() {
	gnatbuild_src_install install

	# there is something strange with provided Makefiles, causing an
	# access violation on gprmake. Have to do funny things..
	make DESTDIR=${D} bindir="${D}${BINPATH}"  install || die
	mv "${D}${D}${PREFIX}/${CTARGET}" "${D}${PREFIX}"
	rm -rf "${D}var"

	gnatbuild_src_install move_libs cleanup prep_env

	# docs have to be fetched from 3rd place, quite messy package
	dodir /usr/share/doc/${PF}/html
	dohtml "${WORKDIR}"/*.html

	# misc notes and examples
	cd ${GNATSOURCE}
	dodoc COPYING README features-503 features-ada0y known-problems-503a
	cp -pPR examples/ "${D}/usr/share/doc/${PF}/"

	# this version of gnat does not provide info files yet
	rm -f ${D}${DATAPATH}/info/gnat.info
}

pkg_postinst() {
	gnatbuild_pkg_postinst

	einfo
	einfo "This is an experimental issue of the gnat-gpl compiler, supporting"
	einfo "some of the new features of Ada2005. You may consider registering with"
	einfo "AdaCore at https://libre2.adacore.com/."
	einfo
	ewarn "Please note!!!"
	ewarn "gnat-gpl is distributed under the GPL-2 license, without the GMGPL provision!!"
	einfo "For the GMGPL version you may look at the gnat-gcc compiler."
	einfo
}
