# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ncbi-tools/ncbi-tools-20031103.ebuild,v 1.5 2004/03/30 20:00:14 spyderous Exp $

DESCRIPTION="NCBI toolkit including the BLAST group of programs, entrez, ddv, udv, sequin and others"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"

SRC_URI="mirror://gentoo/${P}.tar.gz mirror://gentoo/${PN}-data-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="X png"

DEPEND="app-shells/tcsh
		X? ( virtual/x11
			x11-libs/openmotif
			png? ( media-libs/libpng )
		)"

S=${WORKDIR}/${P}

src_compile() {

	cd ${WORKDIR}

	if [ -z "`use X`" ]
	then
		ewarn "No X11 apps will be compiled"
		sed -e "s:\#set HAVE_OGL=0:set HAVE_OGL=0:" -i ncbi/make/makedis.csh
		sed -e "s:\#set HAVE_MOTIF=0:set HAVE_MOTIF=0:" -i ncbi/make/makedis.csh
	fi

	# change to our CFLAGS
	sed -e "s:-O2:${CFLAGS}:" -i ncbi/platform/linux.ncbi.mk

	# put in our MAKEOPTS 
	# VERY BROKEN :: PLEASE FIGURE IT OUT IF YOU CAN...
	# dosed "s/MFLG=\"\"/MFLG=\"${MAKEOPTS}\"/" ncbi/make/makedis.csh

	./ncbi/make/makedis.csh 2>&1 | tee out.makedis.txt

}

src_install() {

	cd ${WORKDIR}/ncbi/bin
	dobin Nentrez blastclust entrcmd getmesh megablast testobj Psequin blastpgp entrez2 getpub ncbisort testval asn2ff cdscan errhdr getseq netentcf udv asn2gb checksub fa2htgs gil2bin rpsblast vecscreen asn2xml copymat fastacmd idfetch seedtop asndhuff ddv findspl impala seqtest asntool demo_regexp fmerge indexpub tbl2asn blastall demo_regexp_grep formatdb makemat test_regexp blastcl3 dosimple getfeat makeset testcore bl2seq


	cd ${WORKDIR}
	dodir /usr/var/ncbi
	insinto /usr/var/ncbi
	doins data/*

	cd ${WORKDIR}/ncbi/doc
	dodoc * images/* fa2htgs/*

	# ncbirc file
	dodir /etc/skel
	insinto /etc/skel
	newins ${FILESDIR}/dot-ncbirc .ncbirc

	# env file
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21ncbi
}

pkg_postinst() {
	einfo " "
	einfo "You'll need to edit /etc/env.d/21ncbi and indicate where your"
	einfo "formatdb formatted databases are going to live on the filesystem."
	einfo "Additionally, you may want to copy /etc/skel/.ncbirc to your"
	einfo "current users home directories."
	einfo " "
	einfo "Be sure to see the /usr/share/doc/${PF} doc directory!"
	einfo " "
}
