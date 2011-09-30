# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mysql-cmake.eclass,v 1.2 2011/09/30 02:10:24 jmbsvicetto Exp $

# @ECLASS: mysql-cmake.eclass
# @MAINTAINER:
# Maintainers:
#	- MySQL Team <mysql-bugs@gentoo.org>
#	- Robin H. Johnson <robbat2@gentoo.org>
#	- Jorge Manuel B. S. Vicetto <jmbsvicetto@gentoo.org>
# @BLURB: This eclass provides the support for cmake based mysql releases
# @DESCRIPTION:
# The mysql-cmake.eclass provides the support to build the mysql
# ebuilds using the cmake build system. This eclass provides
# the src_unpack, src_prepare, src_configure, src_compile, scr_install,
# pkg_preinst, pkg_postinst, pkg_config and pkg_postrm phase hooks.

inherit cmake-utils

#
# HELPER FUNCTIONS:
#

# @FUNCTION: mysql_cmake_disable_test
# @DESCRIPTION:
# Helper function to disable specific tests.
mysql-cmake_disable_test() {

	local rawtestname testname testsuite reason mysql_disable_file
	rawtestname="${1}" ; shift
	reason="${@}"
	ewarn "test '${rawtestname}' disabled: '${reason}'"

	testsuite="${rawtestname/.*}"
	testname="${rawtestname/*.}"
	mysql_disable_file="${S}/mysql-test/t/disabled.def"
	#einfo "rawtestname=${rawtestname} testname=${testname} testsuite=${testsuite}"
	echo ${testname} : ${reason} >> "${mysql_disable_file}"

	if [ -n "${testsuite}" ]; then
		for mysql_disable_file in \
			${S}/mysql-test/suite/${testsuite}/disabled.def  \
			${S}/mysql-test/suite/${testsuite}/t/disabled.def  \
			FAILED ; do
			[ -f "${mysql_disable_file}" ] && break
		done
		if [ "${mysql_disabled_file}" != "FAILED" ]; then
			echo "${testname} : ${reason}" >> "${mysql_disable_file}"
		else
			ewarn "Could not find testsuite disabled.def location for ${rawtestname}"
		fi
	fi
}

# @FUNCTION: configure_cmake_locale
# @DESCRIPTION:
# Helper function to configure locale cmake options
configure_cmake_locale() {

	if ! use minimal && [ -n "${MYSQL_DEFAULT_CHARSET}" -a -n "${MYSQL_DEFAULT_COLLATION}" ]; then
		ewarn "You are using a custom charset of ${MYSQL_DEFAULT_CHARSET}"
		ewarn "and a collation of ${MYSQL_DEFAULT_COLLATION}."
		ewarn "You MUST file bugs without these variables set."

		mycmakeargs+=(
			-DDEFAULT_CHARSET=${MYSQL_DEFAULT_CHARSET}
			-DDEFAULT_COLLATION=${MYSQL_DEFAULT_COLLATION}
		)

	elif ! use latin1 ; then
		mycmakeargs+=(
			-DDEFAULT_CHARSET=utf8
			-DDEFAULT_COLLATION=utf8_general_ci
		)
	else
		mycmakeargs+=(
			-DDEFAULT_CHARSET=latin1
			-DDEFAULT_COLLATION=latin1_swedish_ci
		)
	fi
}

# @FUNCTION: configure_cmake_minimal
# @DESCRIPTION:
# Helper function to configure minimal build
configure_cmake_minimal() {

	mycmakeargs+=(
		-DWITHOUT_SERVER=1
		-DWITHOUT_EMBEDDED_SERVER=1
		-DENABLED_LOCAL_INFILE=1
		-DEXTRA_CHARSETS=none
		-DINSTALL_SQLBENCHDIR=
		-DWITH_SSL=system
		-DWITH_ZLIB=system
		-DWITHOUT_LIBWRAP=1
		-DWITHOUT_READLINE=1
		-DWITHOUT_ARCHIVE_STORAGE_ENGINE=1
		-DWITHOUT_BLACKHOLE_STORAGE_ENGINE=1
		-DWITHOUT_CSV_STORAGE_ENGINE=1
		-DWITHOUT_FEDERATED_STORAGE_ENGINE=1
		-DWITHOUT_HEAP_STORAGE_ENGINE=1
		-DWITHOUT_INNOBASE_STORAGE_ENGINE=1
		-DWITHOUT_MYISAMMRG_STORAGE_ENGINE=1
		-DWITHOUT_MYISAM_STORAGE_ENGINE=1
		-DWITHOUT_PARTITION_STORAGE_ENGINE=1
		-DWITHOUT_INNOBASE_STORAGE_ENGINE=1
	)
}

# @FUNCTION: configure_cmake_standard
# @DESCRIPTION:
# Helper function to configure standard build
configure_cmake_standard() {

	mycmakeargs+=(
		-DENABLED_LOCAL_INFILE=1
		-DEXTRA_CHARSETS=all
		-DMYSQL_USER=mysql
		-DMYSQL_UNIX_ADDR=/var/run/mysqld/mysqld.sock
		-DWITHOUT_READLINE=1
		-DWITH_ZLIB=system
		-DWITHOUT_LIBWRAP=1
	)

	if use static ; then
		mycmakeargs+=( -DDISABLE_SHARED=1 )
	else
		mycmakeargs+=( -DDISABLED_SHARED=0 )
	fi

	mycmakeargs+=(
		$(cmake-utils_use_with debug)
		$(cmake-utils_use_with embedded EMBEDDED_SERVER)
		$(cmake-utils_use_with profiling)
	)

	if use ssl; then
		mycmakeargs+=( -DWITH_SSL=system )
	else
		mycmakeargs+=( -DWITH_SSL=0 )
	fi

	# Storage engines
	mycmakeargs+=(
		-DWITH_ARCHIVE_STORAGE_ENGINE=1
		-DWITH_BLACKHOLE_STORAGE_ENGINE=1
		-DWITH_CSV_STORAGE_ENGINE=1
		-DWITH_HEAP_STORAGE_ENGINE=1
		-DWITH_INNOBASE_STORAGE_ENGINE=1
		-DWITH_MYISAMMRG_STORAGE_ENGINE=1
		-DWITH_MYISAM_STORAGE_ENGINE=1
		-DWITH_PARTITION_STORAGE_ENGINE=1
		$(cmake-utils_use_with extraengine FEDERATED_STORAGE_ENGINE)
	)
}

#
# EBUILD FUNCTIONS
#

# @FUNCTION: mysql-cmake_src_prepare
# @DESCRIPTION:
# Apply patches to the source code and remove unneeded bundled libs.
mysql-cmake_src_prepare() {

	debug-print-function ${FUNCNAME} "$@"

	cd "${S}"

	# Apply the patches for this MySQL version
	EPATCH_SUFFIX="patch"
	mkdir -p "${EPATCH_SOURCE}" || die "Unable to create epatch directory"
	# Clean out old items
	rm -f "${EPATCH_SOURCE}"/*
	# Now link in right patches
	mysql_mv_patches
	# And apply
	epatch

	# last -fPIC fixup, per bug #305873
	i="${S}"/storage/innodb_plugin/plug.in
	[ -f "${i}" ] && sed -i -e '/CFLAGS/s,-prefer-non-pic,,g' "${i}"

	rm -f "scripts/mysqlbug"
}

# @FUNCTION: mysql-cmake_src_configure
# @DESCRIPTION:
# Configure mysql to build the code for Gentoo respecting the use flags.
mysql-cmake_src_configure() {

	debug-print-function ${FUNCNAME} "$@"

	CMAKE_BUILD_TYPE="RelWithDebInfo"

	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DMYSQL_DATADIR=/var/lib/mysql
		-DSYSCONFDIR=/etc/mysql
		-DINSTALL_BINDIR=bin
		-DINSTALL_DOCDIR=share/doc/${P}
		-DINSTALL_DOCREADMEDIR=share/doc/${P}
		-DINSTALL_INCLUDEDIR=include/mysql
		-DINSTALL_INFODIR=share/info
		-DINSTALL_LIBDIR=$(get_libdir)/mysql
		-DINSTALL_MANDIR=share/man
		-DINSTALL_MYSQLDATADIR=/var/lib/mysql
		-DINSTALL_MYSQLSHAREDIR=share/mysql
		-DINSTALL_MYSQLTESTDIR=share/mysql/mysql-test
		-DINSTALL_PLUGINDIR=$(get_libdir)/mysql/plugin
		-DINSTALL_SBINDIR=sbin
		-DINSTALL_SCRIPTDIR=share/mysql/scripts
		-DINSTALL_SQLBENCHDIR=share/mysql
		-DINSTALL_SUPPORTFILESDIR=/usr/share/mysql
		-DWITH_COMMENT="Gentoo Linux ${PF}"
		-DWITHOUT_UNIT_TESTS=1
	)

	configure_cmake_locale

	if use minimal ; then
		configure_cmake_minimal
	else
		configure_cmake_standard
	fi

	# Bug #114895, bug #110149
	filter-flags "-O" "-O[01]"

	CXXFLAGS="${CXXFLAGS} -fno-exceptions -fno-strict-aliasing"
	CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-rtti"
	CXXFLAGS="${CXXFLAGS} -fno-implicit-templates"
	export CXXFLAGS

	# bug #283926, with GCC4.4, this is required to get correct behavior.
	append-flags -fno-strict-aliasing

	cmake-utils_src_configure
}

# @FUNCTION: mysql-cmake_src_compile
# @DESCRIPTION:
# Compile the mysql code.
mysql-cmake_src_compile() {

	debug-print-function ${FUNCNAME} "$@"

	cmake-utils_src_compile
}

# @FUNCTION: mysql-cmake_src_install
# @DESCRIPTION:
# Install mysql.
mysql-cmake_src_install() {

	debug-print-function ${FUNCNAME} "$@"

	# Make sure the vars are correctly initialized
	mysql_init_vars

	cmake-utils_src_install

	# Convenience links
	einfo "Making Convenience links for mysqlcheck multi-call binary"
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqlanalyze"
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqlrepair"
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqloptimize"

	# INSTALL_LAYOUT=STANDALONE causes cmake to create a /usr/data dir
	rm -Rf "${D}/usr/data"

	# Various junk (my-*.cnf moved elsewhere)
	einfo "Removing duplicate /usr/share/mysql files"

	# Clean up stuff for a minimal build
#	if use minimal ; then
#		einfo "Remove all extra content for minimal build"
#		rm -Rf "${D}${MY_SHAREDSTATEDIR}"/{mysql-test,sql-bench}
#		rm -f "${D}"/usr/bin/{mysql{_install_db,manager*,_secure_installation,_fix_privilege_tables,hotcopy,_convert_table_format,d_multi,_fix_extensions,_zap,_explain_log,_tableinfo,d_safe,_install,_waitpid,binlog,test},myisam*,isam*,pack_isam}
#		rm -f "${D}/usr/sbin/mysqld"
#		rm -f "${D}${MY_LIBDIR}"/lib{heap,merge,nisam,my{sys,strings,sqld,isammrg,isam},vio,dbug}.a
#	fi

	# Unless they explicitly specific USE=test, then do not install the
	# testsuite. It DOES have a use to be installed, esp. when you want to do a
	# validation of your database configuration after tuning it.
	if ! use test ; then
		rm -rf "${D}"/${MY_SHAREDSTATEDIR}/mysql-test
	fi

	# Configuration stuff
	case ${MYSQL_PV_MAJOR} in
		5.[1-9]|6*|7*) mysql_mycnf_version="5.1" ;;
	esac
	einfo "Building default my.cnf (${mysql_mycnf_version})"
	insinto "${MY_SYSCONFDIR}"
	doins scripts/mysqlaccess.conf
	mycnf_src="my.cnf-${mysql_mycnf_version}"
	sed -e "s!@DATADIR@!${MY_DATADIR}!g" \
		"${FILESDIR}/${mycnf_src}" \
		> "${TMPDIR}/my.cnf.ok"
	if use latin1 ; then
		sed -i \
			-e "/character-set/s|utf8|latin1|g" \
			"${TMPDIR}/my.cnf.ok"
	fi
	newins "${TMPDIR}/my.cnf.ok" my.cnf

	# Minimal builds don't have the MySQL server
	if ! use minimal ; then
		einfo "Creating initial directories"
		# Empty directories ...
		diropts "-m0750"
		if [[ "${PREVIOUS_DATADIR}" != "yes" ]] ; then
			dodir "${MY_DATADIR}"
			keepdir "${MY_DATADIR}"
			chown -R mysql:mysql "${D}/${MY_DATADIR}"
		fi

		diropts "-m0755"
		for folder in "${MY_LOGDIR}" "/var/run/mysqld" ; do
			dodir "${folder}"
			keepdir "${folder}"
			chown -R mysql:mysql "${D}/${folder}"
		done
	fi

	# Minimal builds don't have the MySQL server
	if ! use minimal ; then
		einfo "Including support files and sample configurations"
		docinto "support-files"
		for script in \
			"${S}"/support-files/my-*.cnf.sh \
			"${S}"/support-files/magic \
			"${S}"/support-files/ndb-config-2-node.ini.sh
		do
			[[ -f "$script" ]] && dodoc "${script}"
		done

		docinto "scripts"
		for script in "${S}"/scripts/mysql* ; do
			[[ -f "$script" ]] && [[ "${script%.sh}" == "${script}" ]] && dodoc "${script}"
		done

	fi

	mysql_lib_symlinks "${D}"
}
