# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-ext-base.eclass,v 1.1 2003/07/24 15:15:50 stuart Exp $
#
# Author: Tal Peer <coredumb@gentoo.org>
#
# The php-ext eclass provides a unified interface for compiling and
# installing standalone PHP extensions ('modules').

ECLASS=php-ext-base
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_install

# ---begin ebuild configurable settings

# The extension name, this must be set, otherwise we die.
[ -z "$PHP_EXT_NAME" ] && die "No module name specified for the php-ext eclass."

# Wether the extensions is a Zend Engine extension
#(defaults to "no" and if you don't know what is it, you don't need it.)
[ -z "$PHP_EXT_ZENDEXT" ] && PHP_EXT_ZENDEXT="no"

# Wether or not to add a line in the php.ini for the extension
# (defaults to "yes" and shouldn't be changed in most cases)
[ -z "$PHP_EXT_INI" ] && PHP_EXT_INI="yes"

# find out where to install extensions
EXT_DIR="`php-config --extension-dir`"

# ---end ebuild configurable settings

DEPEND="${DEPEND}
		virtual/php
		=sys-devel/m4-1.4
		>=sys-devel/libtool-1.4.3"

php-ext-base_buildinilist () {
	# work out the list of .ini files to edit/add to

	if [ -z "${PHPSAPILIST}" ]; then
		PHPSAPILIST="apache1 apache2 cli"
	fi
	
	PHPINIFILELIST=""

	for x in ${PHPSAPILIST} ; do
		if [ -f /etc/php/${x}-php4/php.ini ]; then
			PHPINIFILELIST="${PHPINIFILELIST} etc/php/${x}-php4/php.ini"
		fi
	done
	
	if [[ ${PHPINIFILELIST} = "" ]]; then
		msg="No PHP ini files found for this extension"
		eerror ${msg}
		die ${msg}
	fi

#	einfo "php.ini files found in $PHPINIFILELIST"
}

php-ext-base_src_install() {
	if [ "$PHP_EXT_INI" = "yes" ] ; then
		php-ext-base_buildinilist
		php-ext-base_addextension "${EXT_DIR}/${PHP_EXT_NAME}.so"
	fi
}

php-ext-base_addextension () {
	if [ "${PHP_EXT_ZENDEXT}" = "yes" ]; then
		ext="zend_extension"
	else
		ext="extension"
	fi

	php-ext-base_addtoinifiles "$ext" "$1" "Extension added"
}
	
php-ext-base_setting_is_present () {
	grep "^$1=" $2 > /dev/null 2>&1
}

php-ext-base_inifileinimage () {
	if [ ! -f $1 ]; then
		mkdir -p `dirname $1`
		cp /$1 $1
		insinto /`dirname $1`
		doins $1
	fi
}

# $1 - setting name
# $2 - setting value
# $3 - file to add to
# $4 - sanitised text to output

php-ext-base_addtoinifile () {
	if [ "$1" != "extension" ] && [ "$1" != "zend_extension" ]; then
		php-ext-base_setting_is_present $1 $3 && return
	fi

	php-ext-base_inifileinimage $3

	echo "$1=$2" >> $3

	if [ -z "$4" ]; then
		einfo "Added '$1=$2' to /$3"
	else
		einfo "$4 to $3"
	fi
}

php-ext-base_addtoinifiles () {
	for x in ${PHPINIFILELIST} ; do
		php-ext-base_addtoinifile $1 $2 $x "$3"
	done
}
	

