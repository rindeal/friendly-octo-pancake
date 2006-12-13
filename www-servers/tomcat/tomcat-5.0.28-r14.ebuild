# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tomcat/tomcat-5.0.28-r14.ebuild,v 1.5 2006/12/13 03:13:45 wltjr Exp $

inherit eutils java-pkg

DESCRIPTION="Apache Servlet-2.4/JSP-2.0 Container"

SLOT="${PV/.*}"
SRC_URI="mirror://apache/tomcat/tomcat-${SLOT}/v${PV}/src/jakarta-${P}-src.tar.gz"
HOMEPAGE="http://tomcat.apache.org/"
KEYWORDS="~x86 ~amd64 -ppc -ppc64"
LICENSE="Apache-2.0"
#only one accepted revision of struts to force upgrading because of slot changes
RDEPEND=">=virtual/jdk-1.4
	=dev-java/commons-beanutils-1.7*
	>=dev-java/commons-collections-3.1
	>=dev-java/commons-daemon-1.0
	>=dev-java/commons-dbcp-1.2.1
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-fileupload-1.0
	=dev-java/commons-httpclient-2*
	>=dev-java/commons-el-1.0
	>=dev-java/commons-launcher-0.9
	>=dev-java/commons-logging-1.0.4
	>=dev-java/commons-modeler-1.1
	>=dev-java/commons-pool-1.2
	~dev-java/jaxen-1.0
	>=dev-java/junit-3.8.1
	dev-java/sun-jmx
	>=dev-java/log4j-1.2.8
	=dev-java/jakarta-regexp-1.3*
	>=dev-java/saxpath-1.0
	~dev-java/servletapi-2.4
	=dev-java/struts-1.1-r4
	dev-java/sun-jaf-bin
	>=dev-java/xerces-2.7
	=dev-java/xml-commons-external-1.3*
	jikes? ( dev-java/jikes )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant"
IUSE="doc examples source jikes"

S=${WORKDIR}/jakarta-${P}-src

TOMCAT_NAME="${PN}-${SLOT}"
WEBAPPS_DIR="/var/lib/${TOMCAT_NAME}/webapps"

pkg_setup() {
	# new user for tomcat
	enewgroup tomcat
	enewuser tomcat -1 -1 /dev/null tomcat
	java-pkg_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}

	local PATCHES="
		build.xml-01.patch
		build.xml-02.patch
	"
	for patch in ${PATCHES}; do
		epatch "${FILESDIR}/${PV}/${patch}"
	done

	use jikes && epatch ${FILESDIR}/${PV}/jikes.diff

	# avoid packed jars :-)
	mkdir -p ${S}/jakarta-tomcat-5/build/common
	cd ${S}/jakarta-tomcat-5/build

	mkdir ./bin && cd ./bin
	java-pkg_jar-from commons-logging commons-logging-api.jar
	java-pkg_jar-from sun-jmx jmxri.jar jmx.jar
	java-pkg_jar-from commons-daemon

	mkdir ../common/endorsed && cd ../common/endorsed
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar

	mkdir ../lib && cd ../lib
	java-pkg_jar-from ant-core
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-dbcp
	java-pkg_jar-from commons-el
	java-pkg_jar-from commons-pool
	java-pkg_jar-from servletapi-2.4

	mkdir -p ../../server/lib && cd ../../server/lib
	java-pkg_jar-from commons-beanutils-1.7 commons-beanutils.jar
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-fileupload
	java-pkg_jar-from commons-modeler
	java-pkg_jar-from jakarta-regexp-1.3
}

src_compile(){
	local antflags="-Dbase.path=${T}"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	antflags="${antflags} -Dactivation.jar=$(java-config -p sun-jaf-bin)"
	antflags="${antflags} -Dcommons-collections.jar=$(java-config -p commons-collections)"
	antflags="${antflags} -Dcommons-daemon.jar=$(java-config -p commons-daemon)"
	antflags="${antflags} -Dcommons-digester.jar=$(java-config -p commons-digester)"
	antflags="${antflags} -Dcommons-dbcp.jar=$(java-config -p commons-dbcp)"
	antflags="${antflags} -Dcommons-el.jar=$(java-config -p commons-el)"
	antflags="${antflags} -Dcommons-httpclient.jar=$(java-config -p commons-httpclient)"
	antflags="${antflags} -Dcommons-pool.jar=$(java-config -p commons-pool)"
	antflags="${antflags} -Dcommons-fileupload.jar=$(java-config -p commons-fileupload)"
	antflags="${antflags} -Dcommons-launcher.jar=$(java-config -p commons-launcher)"
	antflags="${antflags} -Dcommons-modeler.jar=$(java-config -p commons-modeler)"
	antflags="${antflags} -Djunit.jar=$(java-config -p junit)"
	antflags="${antflags} -Dlog4j.jar=$(java-config -p log4j)"
	antflags="${antflags} -Dregexp.jar=$(java-config -p jakarta-regexp-1.3)"
	antflags="${antflags} -Dstruts.jar=$(java-pkg_getjar struts-1.1 struts.jar)"
	antflags="${antflags} -Dcommons-beanutils.jar=$(java-pkg_getjar commons-beanutils-1.7 commons-beanutils.jar)"
	antflags="${antflags} -Dcommons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)"
	antflags="${antflags} -Dcommons-logging-api.jar=$(java-pkg_getjar commons-logging commons-logging-api.jar)"
	antflags="${antflags} -Djaxen.jar=$(java-pkg_getjars jaxen)"
	antflags="${antflags} -Djmx.jar=$(java-pkg_getjar sun-jmx jmxri.jar)"
	antflags="${antflags} -Djmx-tools.jar=$(java-pkg_getjar sun-jmx jmxtools.jar)"
	antflags="${antflags} -Dsaxpath.jar=$(java-pkg_getjar saxpath saxpath.jar)"
	antflags="${antflags} -DxercesImpl.jar=$(java-pkg_getjar xerces-2 xercesImpl.jar)"
	antflags="${antflags} -Dxml-apis.jar=$(java-pkg_getjar xml-commons-external-1.3 xml-apis.jar)"
	antflags="${antflags} -Dstruts.home=/usr/share/struts-1.1/"

	ant ${antflags}

}
src_install() {
	cd ${S}/jakarta-tomcat-5/build

	# init.d, conf.d
	newinitd ${FILESDIR}/${PV}/tomcat.init ${TOMCAT_NAME}
	newconfd ${FILESDIR}/${PV}/tomcat.conf ${TOMCAT_NAME}

	if use jikes; then
		sed -e "\cCATALINA_OPTScaCATALINA_OPTS=\"-Dbuild.compiler.emacs=true\"" \
			-i ${D}/etc/conf.d/${TOMCAT_NAME}
	fi

	# create dir structure
	diropts -m755 -o tomcat -g tomcat
	dodir /usr/share/${TOMCAT_NAME}
	keepdir /var/log/${TOMCAT_NAME}/
	keepdir /var/tmp/${TOMCAT_NAME}/
	keepdir /var/run/${TOMCAT_NAME}/

	local CATALINA_BASE=/var/lib/${TOMCAT_NAME}/
	dodir   ${CATALINA_BASE}
	keepdir ${CATALINA_BASE}/shared/lib
	keepdir ${CATALINA_BASE}/shared/classes

	dodir   /etc/${TOMCAT_NAME}
	fperms  750 /etc/${TOMCAT_NAME}

	diropts -m0755

	# we don't need dos scripts
	rm -f bin/*.bat

	# copy the manager and admin context's to the right position
	mkdir -p conf/Catalina/localhost
	cp ${S}/jakarta-tomcat-catalina/webapps/admin/admin.xml \
		conf/Catalina/localhost
	cp ${S}/jakarta-tomcat-catalina/webapps/manager/manager.xml \
		conf/Catalina/localhost

	# make the jars available via java-config -p and jar-from, etc
	base=$(pwd)
	libdirs="common/lib server/lib"
	for dir in ${libdirs}
	do
		cd ${dir}

		for jar in *.jar;
		do
			# replace the file with a symlink
			if [ ! -L ${jar} ]; then
				java-pkg_dojar ${jar}
				rm -f ${jar}
				ln -s ${DESTTREE}/share/${TOMCAT_NAME}/lib/${jar} ${jar}
			fi
		done

		cd ${base}
	done

	# replace a packed struts.jar
	cd server/webapps/admin/WEB-INF/lib
	rm -f struts.jar
	java-pkg_jar-from struts-1.1 struts.jar
	cd ${base}

	# replace the default pw with a random one, see #92281
	local randpw=$(echo ${RANDOM}|md5sum|cut -c 1-15)
	sed -e s:SHUTDOWN:${randpw}: -i conf/{server,server-minimal}.xml

	# copy over the directories
	chown -R tomcat:tomcat webapps/* conf/*
	cp -pR conf/* ${D}/etc/${TOMCAT_NAME} || die "failed to copy conf"
	cp -R bin common server ${D}/usr/share/${TOMCAT_NAME} || die "failed to copy"

	keepdir               ${WEBAPPS_DIR}
	set_webapps_perms     ${D}/${WEBAPPS_DIR}

	# if the useflag is set, copy over the examples
	if use examples; then
		cp -p ../RELEASE-NOTES webapps/ROOT/RELEASE-NOTES.txt
		cp -pr webapps/{tomcat-docs,jsp-examples,servlets-examples,ROOT,webdav} \
			${D}${CATALINA_BASE}/webapps
	fi

	# symlink the directories to make CATALINA_BASE possible
	dosym /etc/${TOMCAT_NAME} ${CATALINA_BASE}/conf
	dosym /var/log/${TOMCAT_NAME} ${CATALINA_BASE}/logs
	dosym /var/tmp/${TOMCAT_NAME} ${CATALINA_BASE}/temp
	dosym /var/run/${TOMCAT_NAME} ${CATALINA_BASE}/work

	cp ${FILESDIR}/${PV}/log4j.properties ${D}/etc/${TOMCAT_NAME}/
	chown tomcat:tomcat ${D}/etc/${TOMCAT_NAME}/log4j.properties

	dodoc  ${S}/build/{RELEASE-NOTES,RUNNING.txt}
	fperms 640 /etc/${TOMCAT_NAME}/tomcat-users.xml
}

pkg_postinst() {
	#due to previous ebuild bloopers, make sure everything is correct
	chown root:root /etc/init.d/${TOMCAT_NAME}
	chown root:root /etc/conf.d/${TOMCAT_NAME}

	einfo
	ewarn " This ebuild implements a new filesystem layout for tomcat"
	ewarn " please read http://www.gentoo.org/proj/en/java/tomcat-guide.xml"
	ewarn " for more information!."
	einfo
	einfo " Please file any bugs at http://bugs.gentoo.org/ or else it"
	einfo " may not get seen.  Thank you."
	einfo

#	einfo "Run emerge --config =${PF}"
#	einfo "to configure Tomcat if you need to for example"
#	einfo "change the home directory of the Tomcat user."
}

#helpers
set_webapps_perms() {
	chown  tomcat:tomcat ${1} || die "Failed to change owner off ${1}."
	chmod  750           ${1} || die "Failed to change permissions off ${1}."
}

pkg_config() {
	# Better suggestions are welcome
	local currentdir="$(getent passwd tomcat | gawk -F':' '{ print $6 }')"

	einfo "The default home directory for Tomcat is /dev/null."
	einfo "You need to change it if your applications needs it to"
	einfo "be an actual directory. Current home directory:"
	einfo "${currentdir}"
	einfo ""
	einfo "Do you want to change it [yes/no]?"

	local answer
	read answer

	if [[ "${answer}" == "yes" ]]; then
		einfo ""
		einfo "Suggestions:"
		einfo "${WEBAPPS_DIR}"
		einfo ""
		einfo "If you want to suggest a directory, file a bug to"
		einfo "http://bugs.gentoo.org"
		einfo ""
		einfo "Enter home directory:"

		local homedir
		read homedir

		einfo ""
		einfo "Setting home directory to: ${homedir}"

		/usr/sbin/usermod -d"${homedir}" tomcat

		einfo "You can run emerge --config =${PF}"
		einfo "again to change to homedir"
		einfo "at any time."
	fi
}
