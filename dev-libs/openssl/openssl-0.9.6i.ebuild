# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.6i.ebuild,v 1.5 2003/02/28 12:43:54 murphy Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/${P}.tar.gz"
HOMEPAGE="http://www.openssl.org/"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=sys-devel/perl-5"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc mips hppa arm"

if [ "$PROFILE_ARCH" = "sparc" -a "`uname -m`" = "sparc64" ]; then
	SSH_TARGET="linux-sparcv8"
fi

src_unpack() {
	unpack ${A} ; cd ${S}

	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff

	if [ "${ARCH}" = "mips" ]
	then
		cd ${S}
		patch -p1 < ${FILESDIR}/openssl-0.9.6-mips.diff || die
	fi

    # many apps linking to openssl needs -fPIC
	if [ "${ARCH}" = "hppa" ]
	then
		CFLAGS="${CFLAGS} -fPIC"
	fi
	if [ "${ARCH}" = "arm" ]; then
		# patch linker to add -ldl or things linking aginst libcrypto fail
		sed -e \
			's!^"linux-elf-arm"\(.*\)::BN\(.*\)!"linux-elf-arm"\1:-ldl:BN\2!' \
			Configure > Configure.orig
	else
		cp Configure Configure.orig
	fi
	sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" Configure.orig > Configure
}

src_compile() {
	if [ ${SSH_TARGET} ]; then
		einfo "Forcing ${SSH_TARGET} compile"
		./Configure ${SSH_TARGET} --prefix=/usr \
			--openssldir=/etc/ssl shared threads || die
	else
		./config --prefix=/usr --openssldir=/etc/ssl shared threads || die
	fi
	# i think parallel make has problems
	make all || die
}

src_install() {
	make INSTALL_PREFIX=${D} MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ LICENSE NEWS README
	dodoc doc/*.txt
	dohtml doc/*
	insinto /usr/share/emacs/site-lisp
	doins doc/c-indentation.el

	# The man pages rand.3 and passwd.1 conflict with other packages
	# Rename them to ssl-* and also make a symlink from openssl-* to ssl-*
	cd ${D}/usr/share/man/man1
	mv passwd.1 ssl-passwd.1
	ln -sf ssl-passwd.1 openssl-passwd.1
	cd ${D}/usr/share/man/man3
	mv rand.3 ssl-rand.3
	ln -sf ssl-rand.3 openssl-rand.3

	# create the certs directory.  Previous openssl builds
	# would need to create /usr/lib/ssl/certs but this looks
	# to be the more FHS compliant setup... -raker
	dodir /etc/ssl/certs

}

