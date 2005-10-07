# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-gcc/xmingw-gcc-3.4.4.ebuild,v 1.3 2005/10/07 17:54:38 cretin Exp $

inherit eutils

MY_P=${P/xmingw-/}
S=${WORKDIR}/${MY_P}
MINGW_PATCH=gcc-3.4.4-20050522-1-src.diff.gz
RUNTIME=mingw-runtime-3.7
W32API=w32api-3.2

DESCRIPTION="The GNU Compiler Collection - i386-mingw32msvc-gcc only"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${MY_P}/${MY_P}.tar.bz2
		mirror://sourceforge/mingw/${MINGW_PATCH}
		mirror://sourceforge/mingw/${RUNTIME}-src.tar.gz
		mirror://sourceforge/mingw/${W32API}-src.tar.gz
		mirror://gentoo/gcc-3.4.4-crossfix.diff.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fortran gcj debug nocxx"

DEPEND="dev-util/xmingw-binutils"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	unpack ${RUNTIME}-src.tar.gz
	unpack ${W32API}-src.tar.gz
	cd ${S}; gzip -dc ${DISTDIR}/${MINGW_PATCH} | patch -p1
	patch -p1 < ${FILESDIR}/gcc-3.4.1-includefix.diff
	epatch ${DISTDIR}/gcc-3.4.4-crossfix.diff.bz2

	mkdir -p ${S}/winsup/cygwin ${S}/winsup/w32api
	cd ${S}/winsup/cygwin;ln -s ${WORKDIR}/${RUNTIME}/include .
	cd ${S}/winsup/w32api;ln -s ${WORKDIR}/${W32API}/include .
}

src_compile() {
	export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
	unset CFLAGS CXXFLAGS
	myconf=""
	if has_version dev-util/xmingw-runtime \
	&& has_version dev-util/xmingw-w32api
	then
		lang=c
		use nocxx || lang="${lang},c++"
		use fortran && lang="${lang},f77"

		if use gcj; then
			lang=${lang},java
			myconf="${myconf} --enable-libgcj --disable-libgcj-debug --disable-java-awt \
				--enable-java-gc=boehm --enable-interpreter --enable-hash-sychronization"
		fi
	else
		lang=c
	fi

	if use debug; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	./configure \
		--target=i386-mingw32msvc \
		--prefix=/opt/xmingw \
		--enable-languages=${lang} \
		--disable-shared \
		--disable-nls \
		--enable-threads \
		--with-gcc \
		--disable-win32-registry \
		--enable-sjlj-exceptions \
		--without-x \
		--without-newlib \
		${myconf} \
			|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
	make DESTDIR="${D}" install || die "make install failed"
	doenvd ${FILESDIR}/05xmingw
	rm ${D}/opt/xmingw/info/dir ${D}/opt/xmingw/lib/libiberty.a
}

pkg_config() {
	einfo "Now emerge dev-util/xmingw-runtime and remerge dev-util/xmingw-gcc"
	einfo "if you require fortran, java or C++ support"
}
