# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Robin H. Johnson <robbat2@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/php.eclass,v 1.1 2003/04/23 09:50:02 robbat2 Exp $
ECLASS=php
INHERITED="$INHERITED $ECLASS"

import eutils flag-o-matic

EXPORT_FUNCTIONS src_unpack src_compile src_install 

MY_P=php-${PV}
S=${WORKDIR}/${MY_P}
[ -z "$HOMEPAGE" ]	&& HOMEPAGE="http://www.php.net/"
[ -z "$LICENSE" ]	&& LICENSE="PHP"
[ -z "$SRC_URI" ] 	&& SRC_URI="http://us3.php.net/distributions/${MY_P}.tar.bz2"
[ -z "$PROVIDE" ]	&& PROVIDE="virtual/php"

IUSE="${IUSE} X berkdb cjk crypt curl firebird flash freetds gd gdbm imap jpeg ldap libwww mysql nls oci8 odbc pam pdflib png postgres qt snmp spell ssl tiff truetype xml xml2"
#removed: java gmp
#both cause breakage

DEPEND="${DEPEND}
    X? ( virtual/x11 )
    berkdb? ( >=sys-libs/db-3 )
    crypt? ( >=dev-libs/libmcrypt-2.4 >=app-crypt/mhash-0.8 )
    curl? ( >=net-ftp/curl-7.10.2 )
    firebird? ( >=dev-db/firebird-1.0 )
    flash? ( media-libs/libswf >=media-libs/ming-0.2a )
    freetds? ( >=dev-db/freetds-0.53 )
    gd? ( media-libs/libgd )
    gdbm? ( >=sys-libs/gdbm-1.8.0 )
    imap? ( >=net-mail/uw-imap-2001a-r1 )
    jpeg? ( >=media-libs/jpeg-6b )
    ldap? ( >=net-nds/openldap-1.2.11 )
    libwww? ( >=net-libs/libwww-5.3.2 )
    mysql? ( >=dev-db/mysql-3.23.26 )
    nls? ( sys-devel/gettext )
    odbc? ( >=dev-db/unixODBC-1.8.13 )
    pam? ( >=sys-libs/pam-0.75 )
    pdflib? ( >=media-libs/pdflib-4.0.1-r2 )
    png? ( >=media-libs/libpng-1.2.5 )
    postgres? ( >=dev-db/postgresql-7.1 )
    qt? ( x11-libs/qt )
    snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
    spell? ( app-text/aspell )
    ssl? ( >=dev-libs/openssl-0.9.5 )
    tiff? ( >=media-libs/tiff-3.5.5 )
    truetype? ( ~media-libs/freetype-1.3.1 >=media-libs/t1lib-1.3.1 )
    xml2? ( dev-libs/libxml2 )
    xml? ( >=net-libs/libwww-5.3.2 >=app-text/sablotron-0.96 )
	"


RDEPEND="${RDEPEND}
	xml? ( >=app-text/sablotron-0.95-r1 >=net-libs/libwww-5.3.2 )
	qt? ( >=x11-libs/qt-2.3.0 )"


#fixes bug #14067
replace-flags "-march=k6*" "-march=i586"

php_src_unpack() {
    unpack ${MY_P}.tar.bz2
    cd ${S}

    # Configure Patch for wired uname -a
    mv configure configure.old
    cat configure.old | sed "s/PHP_UNAME=\`uname -a\`/PHP_UNAME=\`uname -s -n -r -v\`/g" > configure
    chmod 755 configure

    # fix PEAR installer
    cp pear/PEAR/Registry.php pear/PEAR/Registry.old
    sed "s:\$pear_install_dir\.:\'$D/usr/lib/php/\' . :g" pear/PEAR/Registry.old > pear/PEAR/Registry.php

	#if [ "`use java`" ] ; then

	#	cp configure configure.orig
	#	cat configure.orig | \
	#		sed -e 's/LIBS="-lttf $LIBS"/LIBS="-lttf $LIBS"/' \
	#		> configure

	#	cp ext/gd/gd.c ext/gd/gd.c.orig
	#	cat ext/gd/gd.c.orig | \
	#		sed -e "s/typedef FILE gdIOCtx;//" \
	#		> ext/gd/gd.c
	#	if [ "$JAVAC" ];
	#	then
	#              cp ext/java/Makefile.in ext/java/Makefile.in.orig
	#              cat ext/java/Makefile.in.orig | \
	#                      sed -e "s/^\tjavac/\t\$(JAVAC)/" \
	#                      > ext/java/Makefile.in
	#	fi
	#fi

	# pear's world writable files is a php issue fixed in their cvs tree.
	# http://bugs.php.net/bug.php?id=20978
	# http://bugs.php.net/bug.php?id=20974
	epatch ${FILESDIR}/pear_config.diff || die "epatch failed"

}

myconf="${myconf}"

php_src_compile() {
	use berkdb && myconf="${myconf} --with-db3=/usr"
	#---
	use cjk && myconf="${myconf} --enable-mbstring --enable-mbregex"
	#use cjk && myconf="${myconf} --enable-mbstring"
	#---
	use curl && myconf="${myconf} --with-curl"
	use crypt && myconf="${myconf} --enable-mcrypt=/usr --with-mhash"
	use firebird && myconf="${myconf} --with-interbase=/opt/interbase"
	use flash && myconf="${myconf} --with-swf=/usr --with-ming=/usr"
	use freetds && myconf="${myconf} --with-sybase=/usr"
	use gd && myconf="${myconf} --with-gd=/usr"
	use gdbm && myconf="${myconf} --with-gdbm=/usr"
	#--- check out this weirdness
	#use jpeg && myconf="${myconf} --with-jpeg-dir=/usr"
	#use jpeg && myconf="${myconf} --with-jpeg-dir=/usr/lib" || myconf="${myconf} --without-jpeg"
	use jpeg && myconf="${myconf} --with-jpeg-dir=/usr" || myconf="${myconf} --without-jpeg"
	#---
	use libwww && myconf="${myconf} --with-xml" || myconf="${myconf} --disable-xml"
	use ldap &&  myconf="${myconf} --with-ldap"
	use mysql && myconf="${myconf} --with-mysql=/usr" || myconf="${myconf} --without-mysql"
	use nls && myconf="${myconf} --with-gettext" || myconf="${myconf} --without-gettext"
	use odbc && myconf="${myconf} --with-unixODBC=/usr"
	use pam && myconf="${myconf} --with-pam"
	use pdflib && myconf="${myconf} --with-pdflib=/usr"
	#---
	use png && myconf="${myconf} --with-png-dir=/usr"
	use png || myconf="${myconf} --without-png"
	#---
	use postgres && myconf="${myconf} --with-pgsql=/usr"
	use qt && myconf="${myconf} --with-qtdom" 
	use snmp && myconf="${myconf} --with-snmp --enable-ucd-snmp-hack"
	use spell && myconf="${myconf} --with-pspell"
	use ssl && myconf="${myconf} --with-openssl"
	use tiff && myconf="${myconf} --with-tiff-dir=/usr" || myconf="${myconf} --without-tiff"
	use truetype && myconf="${myconf} --with-ttf --with-t1lib"
	use xml2 && myconf="${myconf} --with-dom"
	use zlib && myconf="${myconf} --with-zlib --with-zlib-dir=/usr/lib"

	# optional support for oracle oci8
	use oci8 && [ -n "$ORACLE_HOME" ] && myconf="${myconf} --with-oci8=${ORACLE_HOME}"

	use imap && use ssl && \
	if [ "`strings ${ROOT}/usr/lib/c-client.a \ | grep ssl_onceonlyinit`" ] ; then
		echo "Compiling imap with SSL support"
		myconf="${myconf} --with-imap --with-imap-ssl"
	else
		echo "Compiling imap without SSL support"
		myconf="${myconf} --with-imap"
	fi

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"
	if [ "`use X`" ] ; then
		myconf="${myconf} --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
	
	if [ "`use xml`" ] ; then
		export LIBS="-lxmlparse -lxmltok"
		myconf="${myconf} --with-sablot=/usr"
		myconf="${myconf} --enable-xslt" 
		myconf="${myconf} --with-xslt-sablot" 
		myconf="${myconf} --with-xmlrpc"
	fi
	
	#use java && myconf="${myconf} --with-java=${JAVA_HOME}"

	myconf="${myconf} \
		--enable-bcmath \
		--enable-calendar \
		--enable-dbase \
		--enable-ftp \
		--enable-exif \
		--enable-inline-optimization \
		--enable-sockets \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-track-vars \
		--enable-trans-sid \
		--enable-versioning \
		--with-config-file-path=/etc/php4 \
		--with-bz2 \
	"
	#this is some stuff that MIGHT be questionable in some ebuilds
	myconf="${myconf} \
		--enable-wddx \
		--host=${CHOST} \
		--prefix=/usr"
	#dev-php/php: wddx pear
	#dev-php/mod_php: prefix host

	econf \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"

}


php_src_install() {
	addwrite /usr/share/snmp/mibs/.index
	
	# put make here

	dodoc CODING_STANDARDS LICENSE EXTENSIONS 
	dodoc RELEASE_PROCESS README.* TODO NEWS
	dodoc ChangeLog* *.txt

	#install scripts
	exeinto /usr/bin
	doexe ${S}/pear/scripts/phpize
	doexe ${S}/pear/scripts/php-config
	doexe ${S}/pear/scripts/phpextdist
	doexe ${S}/ext/ext_skel
	
	# PHP module building stuff
	mkdir ${D}/usr/lib/php/build
	insinto /usr/lib/php/build
	doins build/* pear/pear.m4 acinclude.m4 configure.in Makefile.global scan_makefile_in.awk

    #revert Pear patch
    rm ${D}/usr/lib/php/PEAR/Registry.php
    mv ${S}/pear/PEAR/Registry.old ${D}/usr/lib/php/PEAR/Registry.php
	
}
