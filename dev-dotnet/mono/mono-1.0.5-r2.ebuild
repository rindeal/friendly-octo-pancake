# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-1.0.5-r2.ebuild,v 1.5 2005/01/01 17:49:12 eradicator Exp $

inherit eutils mono flag-o-matic debug

MCS_P=${P/mono/mcs}
MCS_S=${WORKDIR}/${MCS_P}

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz
		http://www.go-mono.com/archive/${PV}/${MCS_P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11)"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	>=dev-libs/icu-2.6.1
	!dev-dotnet/pnet
	ppc? (
		>=sys-devel/gcc-3.2.3-r4
		>=sys-libs/glibc-2.3.3_pre20040420
	)"
RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${MCS_P}-pathfix.diff

	# Disable installing the precompiled mcs/classlibs
	sed -i "s: runtime : :" ${S}/Makefile.in
	# Fix the path for the jay man page
	sed -i "s:man/man1:share/man/man1:" ${MCS_S}/jay/Makefile

	# Ugly sed to replace windows path with *nix equivalent
	for file in $(find ${MCS_S}/nunit20 -name AssemblyInfo.cs)
	do
		sed -i "s:\.\.\\\\\\\\:../:g" "${file}"
	done

	# Fix MONO_CFG_DIR for signing
	sed -i \
		"s:^\t\(MONO.*SNK)\):\tMONO_CFG_DIR='${D}/etc/' \1:" \
		${MCS_S}/build/library.make

	# add our own little in-place mcs script
	echo "${S}/mono/mini/mono ${S}/runtime/mcs.exe \"\$@\" " > ${S}/runtime/mcs
	chmod +x ${S}/runtime/mcs

	echo "${S}/mono/mini/mono ${S}/runtime/monoresgen.exe \"\$@\" " > ${S}/runtime/monoresgen
	chmod +x ${S}/runtime/monoresgen

	PATH="${S}/runtime:${PATH}"
	export PATH
}

src_compile() {
	strip-flags

	if have_NPTL
	then
		eerror "To use mono with an NPTL enabled glibc, please emerge"
		eerror "mono-${PV}-r3."
		die "NPTL glibc not support by this release"
	fi

	econf --with-tls=pthread --with-sigaltstack=yes || die
	emake -j1 || die "mono runtime compilation failure"

	cd ${S}
	ln -s ../runtime ${WORKDIR}/${P}/runtime/lib

	cd ${MCS_S}
	echo "prefix=${S}/runtime" > build/config.make
	echo "MONO_PATH=${S}/runtime/net_1_1" >> build/config.make
	echo "BOOTSTRAP_MCS=${S}/runtime/mcs" >> build/config.make
	echo "RUNTIME=${S}/mono/mini/mono \${RUNTIME_FLAGS}" >> build/config.make
	echo "PATH=${S}/runtime:${PATH}" >> build/config.make
	echo "export PATH" >> build/config.make
	echo "export MONO_PATH" >> build/config.make
	emake -j1 PLATFORM=linux || die "mcs compiler compilation failure"
	echo "prefix=/usr" >> build/config.make
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
	docinto docs
	dodoc docs/*
	docinto libgc
	dodoc libgc/ChangeLog

	cd ${MCS_S}
	make DESTDIR=${D} install || die

	docinto mcs
	dodoc AUTHORS README* ChangeLog INSTALL.txt
	docinto mcs/docs
	dodoc docs/*.txt

	# Remove some extraneous tools
	cd ${D}/usr/bin
	rm {CorCompare,EnumCheck,GenerateDelegate,ictool,IFaceDisco}.exe
	rm nunit-console.exe

	# init script
	exeinto /etc/init.d ; newexe ${FILESDIR}/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${FILESDIR}/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	einfo "If you want to avoid typing '<runtime> program.exe'"
	einfo "you can configure your runtime in /etc/conf.d/dotnet"
	einfo "Use /etc/init.d/dotnet to register your runtime"
	echo
}
