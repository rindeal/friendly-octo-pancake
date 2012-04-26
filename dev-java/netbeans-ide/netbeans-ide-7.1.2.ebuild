# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-ide/netbeans-ide-7.1.2.ebuild,v 1.1 2012/04/26 21:47:59 fordfrog Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans IDE Cluster"
HOMEPAGE="http://netbeans.org/projects/ide"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.2/final/zip/netbeans-7.1.2-201204101705-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/B7ADB35C7BC16AFA8AE49C4D61F87E607BDADB41-antlr-runtime-3.3.jar
	http://hg.netbeans.org/binaries/886FAF4B85054DD6E50D9B3438542F432B5F9251-bytelist-0.1.jar
	http://hg.netbeans.org/binaries/A8762D07E76CFDE2395257A5DA47BA7C1DBD3DCE-commons-io-1.4.jar
	http://hg.netbeans.org/binaries/643CC426B9F75AA111FAC0FAC0E52FF5D991A337-commons-net-3.0.1.jar
	http://hg.netbeans.org/binaries/901D8F815922C435D985DA3814D20E34CC7622CB-css21-spec.zip
	http://hg.netbeans.org/binaries/53AFD6CAA1B476204557B0626E7D673FBD5D245C-css3-spec.zip
	http://hg.netbeans.org/binaries/C9A6304FAA121C97CB2458B93D30B1FD6F0F7691-derbysampledb.zip
	http://hg.netbeans.org/binaries/23123BB29025254556B6E573023FCDF0F6715A66-html-4.01.zip
	http://hg.netbeans.org/binaries/77DB1AFF3C0730C144D30C9935A1CD8DCD2488A9-html5-datatypes.jar
	http://hg.netbeans.org/binaries/4388C34B9F085A42FBEA06C5B00FDF0A251171EC-html5doc.zip
	http://hg.netbeans.org/binaries/D528B44AE7593D2275927396BF930B28078C5220-htmlparser-1.2.1.jar
	http://hg.netbeans.org/binaries/8E737D82ECAC9BA6100A9BBA71E92A381B75EFDC-ini4j-0.5.1.jar
	http://hg.netbeans.org/binaries/A2862B7795EF0E0F0716BEC84528FA3B629E479C-io-xml-util.jar
	http://hg.netbeans.org/binaries/0DCC973606CBD9737541AA5F3E76DED6E3F4D0D0-iri.jar
	http://hg.netbeans.org/binaries/FACC6D84B0B0A650B1D44FED941E9ADD9F326862-isorelax20041111.jar
	http://hg.netbeans.org/binaries/F90E3DA5259DB07F36E6987EFDED647A5231DE76-ispell-enwl-3.1.20.zip
	http://hg.netbeans.org/binaries/BCF23B1D858C6F69D67C851D497984D25345D0B1-jaxb-api.jar
	http://hg.netbeans.org/binaries/27FAE927B5B9AE53A5B0ED825575DD8217CE7042-jaxb-api-doc.zip
	http://hg.netbeans.org/binaries/2EC69BD69B66B0DABEA392DE713A11F975001760-jaxb-impl.jar
	http://hg.netbeans.org/binaries/64D468922B85A9626178AEDF564FFDBDE980B3EC-jaxb-xjc.jar
	http://hg.netbeans.org/binaries/F02664A059617D060BEC3EBA0BC002B2102AEB84-jaxb1-impl.jar
	http://hg.netbeans.org/binaries/C0C5653D2200F2BD2E834B26DFDBC830D07FA0F4-jing.jar
	http://hg.netbeans.org/binaries/71F7D2D5A3CF17CECBD15049A856BC0245C95C56-js.jar
	http://hg.netbeans.org/binaries/098B14300B35E1053AA9945FF2C1CDA164F43B33-js-domstubs.zip
	http://hg.netbeans.org/binaries/5756AA27E54A3EC6C8CDAE32F49BCA7BC139EB15-jsstubs.zip
	http://hg.netbeans.org/binaries/2E07375E5CA3A452472F0E87FB33F243F7A5C08C-libpam4j-1.1.jar
	http://hg.netbeans.org/binaries/A1C0ED8C43A306E3FB7676E7463204B9DA9BE290-non-schema.jar
	http://hg.netbeans.org/binaries/DF8DD2981C9C3EBEDB059CA98450B587E784AF58-org.eclipse.core.contenttype-3.4.100.jar
	http://hg.netbeans.org/binaries/A71B23F287BB0CB27E3A5B7808AC07D45BE44841-org.eclipse.core.jobs-3.5.1.jar
	http://hg.netbeans.org/binaries/93CDEDB00404BF3C56AD3BF0501A9E7A09BD2108-org.eclipse.core.net-1.2.100.jar
	http://hg.netbeans.org/binaries/46735A729401036FC2C14CC05257ACB4CD4F6906-org.eclipse.core.runtime-3.6.0.jar
	http://hg.netbeans.org/binaries/9C98C277CFFBB4CA06CAFD5820562EF7B5100F5C-org.eclipse.core.runtime.compatibility.auth-3.2.200.jar
	http://hg.netbeans.org/binaries/8A288BD66E90B1081F843A17F95973514ED55A97-org.eclipse.equinox.app-1.3.1.jar
	http://hg.netbeans.org/binaries/491025C38F84A6FF9823315A74A0CAC4C30E51A8-org.eclipse.equinox.common-3.6.0.jar
	http://hg.netbeans.org/binaries/F411AB988320260361C3611714CA5AF1480CD1A3-org.eclipse.equinox.preferences-3.3.0.jar
	http://hg.netbeans.org/binaries/AD19FF36B5D976E5B4F289B5ACB32967216C1B2D-org.eclipse.equinox.registry-3.5.0.jar
	http://hg.netbeans.org/binaries/1FE453D0B251571463F9BE4F51F413BBA5A376A7-org.eclipse.equinox.security-1.0.200.jar
	http://hg.netbeans.org/binaries/34E70691382D67EE5C84EF207FB8D3784594BA2C-org.eclipse.jgit-1.0.0.201106090707-r.jar
	http://hg.netbeans.org/binaries/6AC191F42860D1698C9268AE044AFAA5FE806CE7-org.eclipse.mylyn.bugzilla.core-3.6.0.jar
	http://hg.netbeans.org/binaries/4617423828BC2E79A1871949C2914285405D8EFF-org.eclipse.mylyn.commons.core-3.6.0.jar
	http://hg.netbeans.org/binaries/053602E0177D42BF707019F1BC646193A899D571-org.eclipse.mylyn.commons.net-3.6.0.jar
	http://hg.netbeans.org/binaries/032EFC784E1DE21E4093C08F336C7582F5694760-org.eclipse.mylyn.commons.xmlrpc-3.6.0.jar
	http://hg.netbeans.org/binaries/5D73EEAEABC42C6FCB85593D1F5B04ACBDFAA0F9-org.eclipse.mylyn.tasks.core-3.6.0.jar
	http://hg.netbeans.org/binaries/CD33537FD47E801E01B427997F3DE4016159B414-preindexed.zip
	http://hg.netbeans.org/binaries/E66876EB5F33AA0E57F035F1AADD8C44FEAE7FCB-processtreekiller-1.0.1.jar
	http://hg.netbeans.org/binaries/B0D0FCBAC68826D2AFA3C7C89FC4D57B95A000C3-resolver-1.2.jar
	http://hg.netbeans.org/binaries/1162833E0FE87B69B99B1F7DEB3A6C386EAB6F84-rhino1_7R2rc1.zip
	http://hg.netbeans.org/binaries/C56F4F5C42102A67F56EB8F12D0219E92E5307C2-sdocs.zip
	http://hg.netbeans.org/binaries/0B9606F570B28FFC4FCE6C7222B88B3DCEFB1A36-svnClientAdapter-javahl-1.6.13.jar
	http://hg.netbeans.org/binaries/A11623D2AF72A99C1509EC2A0ADA2DACBEE9A8E4-svnClientAdapter-main-1.6.13.jar
	http://hg.netbeans.org/binaries/0AE20EC02958F193ADAB4C272ACCF6FE3196DCA0-svnClientAdapter-svnkit-1.6.13.jar
	http://hg.netbeans.org/binaries/636C6FF256A978B786D7502F43E788448E9DAB4B-svnkit-1.3.4.jar
	http://hg.netbeans.org/binaries/AB271CFC19469D9088BE306685A7AC8787373F99-svnkit-javahl.jar
	http://hg.netbeans.org/binaries/7C6ED64C55164C5AE0394E11303CA95CB24166AF-swingx-0.9.5.jar
	http://hg.netbeans.org/binaries/538D727A9A0874019FB11280F07CE3F43EE723BC-sqljet-1.0.3.jar
	http://hg.netbeans.org/binaries/CD5B5996B46CB8D96C8F0F89A7A734B3C01F3DF7-tomcat-webserver-3.2.jar
	http://hg.netbeans.org/binaries/68B82D7246FD90E0FC70BB9C8F10611489BF371A-trilead.jar
	http://hg.netbeans.org/binaries/55CD0B272084EB80B8C91F3A0617BB602B4EF2DF-ValidationAPI.jar
	http://hg.netbeans.org/binaries/7A5A7DF07297A86A944D4D0562C685585B0734EF-validator.jar
	http://hg.netbeans.org/binaries/C9757EFB2CFBA523A7375A78FA9ECFAF0D0AC505-winp-1.14-patched.jar
	http://hg.netbeans.org/binaries/64F5BEEADD2A239C4BC354B8DFDB97CF7FDD9983-xmlrpc-client-3.0.jar
	http://hg.netbeans.org/binaries/8FA16AD28B5E79A7CD52B8B72985B0AE8CCD6ADF-xmlrpc-common-3.0.jar
	http://hg.netbeans.org/binaries/D6917BF718583002CBE44E773EE21E2DF08ADC71-xmlrpc-server-3.0.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-platform-${PV}
	dev-java/commons-httpclient:3
	dev-java/commons-io:1
	dev-java/commons-lang:2.1
	dev-java/commons-logging:0
	dev-java/freemarker:2.3
	dev-java/icu4j:4.4
	dev-java/jdbc-mysql:0
	dev-java/jdbc-postgresql:0
	dev-java/jsr173:0
	dev-java/jvyamlb:0
	dev-java/log4j:0
	dev-java/lucene:3.0
	dev-java/saxon:9
	dev-java/smack:2.2
	dev-java/sun-jaf:0
	dev-java/tomcat-servlet-api:2.2
	dev-java/ws-commons-util:0
	dev-java/xerces:2
	dev-vcs/subversion:0[java]"
#	dev-java/jaxb:2 upstream version contains more stuff so websvccommon does not compile with ours
#	app-text/jing:0 our version is probably too old
#	dev-java/ini4j:0 our version is too old
#	java-virtuals/jaf:0 could use this instead of sun-jaf but it returns empty classpath
#	dev-java/trilead-ssh2:0 in overlay
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	dev-java/commons-codec:0
	dev-java/jsch:0
	dev-java/jzlib:0
	${CDEPEND}
	dev-java/javacc:0
	dev-java/javahelp:0"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.ide -Dext.binaries.downloaded=true -Djava.awt.headless=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/B7ADB35C7BC16AFA8AE49C4D61F87E607BDADB41-antlr-runtime-3.3.jar libs.antlr3.runtime/external/antlr-runtime-3.3.jar || die
	ln -s "${DISTDIR}"/886FAF4B85054DD6E50D9B3438542F432B5F9251-bytelist-0.1.jar libs.bytelist/external/bytelist-0.1.jar || die
	ln -s "${DISTDIR}"/643CC426B9F75AA111FAC0FAC0E52FF5D991A337-commons-net-3.0.1.jar libs.commons_net/external/commons-net-3.0.1.jar || die
	# system commons-io fails with following error:
	# Missing manifest tag OpenIDE-Module; /var/tmp/portage/dev-java/netbeans-ide-9999_p20110911/work/nbbuild/netbeans/ide/modules/org-apache-commons-io.jar is not a module
	ln -s "${DISTDIR}"/A8762D07E76CFDE2395257A5DA47BA7C1DBD3DCE-commons-io-1.4.jar o.apache.commons.io/external/commons-io-1.4.jar ||die
	ln -s "${DISTDIR}"/901D8F815922C435D985DA3814D20E34CC7622CB-css21-spec.zip css.editor/external/css21-spec.zip || die
	ln -s "${DISTDIR}"/53AFD6CAA1B476204557B0626E7D673FBD5D245C-css3-spec.zip css.editor/external/css3-spec.zip || die
	ln -s "${DISTDIR}"/C9A6304FAA121C97CB2458B93D30B1FD6F0F7691-derbysampledb.zip derby/external/derbysampledb.zip || die
	ln -s "${DISTDIR}"/23123BB29025254556B6E573023FCDF0F6715A66-html-4.01.zip html.editor/external/html-4.01.zip || die
	ln -s "${DISTDIR}"/77DB1AFF3C0730C144D30C9935A1CD8DCD2488A9-html5-datatypes.jar html.validation/external/html5-datatypes.jar || die
	ln -s "${DISTDIR}"/4388C34B9F085A42FBEA06C5B00FDF0A251171EC-html5doc.zip html.parser/external/html5doc.zip || die
	ln -s "${DISTDIR}"/D528B44AE7593D2275927396BF930B28078C5220-htmlparser-1.2.1.jar html.parser/external/htmlparser-1.2.1.jar || die
	ln -s "${DISTDIR}"/8E737D82ECAC9BA6100A9BBA71E92A381B75EFDC-ini4j-0.5.1.jar libs.ini4j/external/ini4j-0.5.1.jar || die
	ln -s "${DISTDIR}"/A2862B7795EF0E0F0716BEC84528FA3B629E479C-io-xml-util.jar html.validation/external/io-xml-util.jar || die
	ln -s "${DISTDIR}"/0DCC973606CBD9737541AA5F3E76DED6E3F4D0D0-iri.jar html.validation/external/iri.jar || die
	ln -s "${DISTDIR}"/FACC6D84B0B0A650B1D44FED941E9ADD9F326862-isorelax20041111.jar html.validation/external/isorelax20041111.jar || die
	ln -s "${DISTDIR}"/F90E3DA5259DB07F36E6987EFDED647A5231DE76-ispell-enwl-3.1.20.zip spellchecker.dictionary_en/external/ispell-enwl-3.1.20.zip || die
	ln -s "${DISTDIR}"/BCF23B1D858C6F69D67C851D497984D25345D0B1-jaxb-api.jar xml.jaxb.api/external/jaxb-api.jar || die
	ln -s "${DISTDIR}"/27FAE927B5B9AE53A5B0ED825575DD8217CE7042-jaxb-api-doc.zip libs.jaxb/external/jaxb-api-doc.zip || die
	ln -s "${DISTDIR}"/2EC69BD69B66B0DABEA392DE713A11F975001760-jaxb-impl.jar libs.jaxb/external/jaxb-impl.jar || die
	ln -s "${DISTDIR}"/64D468922B85A9626178AEDF564FFDBDE980B3EC-jaxb-xjc.jar libs.jaxb/external/jaxb-xjc.jar || die
	ln -s "${DISTDIR}"/F02664A059617D060BEC3EBA0BC002B2102AEB84-jaxb1-impl.jar libs.jaxb/external/jaxb1-impl.jar || die
	ln -s "${DISTDIR}"/C0C5653D2200F2BD2E834B26DFDBC830D07FA0F4-jing.jar html.validation/external/jing.jar || die
	ln -s "${DISTDIR}"/71F7D2D5A3CF17CECBD15049A856BC0245C95C56-js.jar html.validation/external/js.jar || die
	ln -s "${DISTDIR}"/098B14300B35E1053AA9945FF2C1CDA164F43B33-js-domstubs.zip javascript.editing/external/js-domstubs.zip || die
	ln -s "${DISTDIR}"/5756AA27E54A3EC6C8CDAE32F49BCA7BC139EB15-jsstubs.zip javascript.editing/external/jsstubs.zip || die
	ln -s "${DISTDIR}"/2E07375E5CA3A452472F0E87FB33F243F7A5C08C-libpam4j-1.1.jar extexecution.destroy/external/libpam4j-1.1.jar || die
	ln -s "${DISTDIR}"/A1C0ED8C43A306E3FB7676E7463204B9DA9BE290-non-schema.jar html.validation/external/non-schema.jar || die
	ln -s "${DISTDIR}"/DF8DD2981C9C3EBEDB059CA98450B587E784AF58-org.eclipse.core.contenttype-3.4.100.jar o.eclipse.core.contenttype/external/org.eclipse.core.contenttype-3.4.100.jar || die
	ln -s "${DISTDIR}"/A71B23F287BB0CB27E3A5B7808AC07D45BE44841-org.eclipse.core.jobs-3.5.1.jar o.eclipse.core.jobs/external/org.eclipse.core.jobs-3.5.1.jar || die
	ln -s "${DISTDIR}"/93CDEDB00404BF3C56AD3BF0501A9E7A09BD2108-org.eclipse.core.net-1.2.100.jar o.eclipse.core.net/external/org.eclipse.core.net-1.2.100.jar || die
	ln -s "${DISTDIR}"/46735A729401036FC2C14CC05257ACB4CD4F6906-org.eclipse.core.runtime-3.6.0.jar o.eclipse.core.runtime/external/org.eclipse.core.runtime-3.6.0.jar || die
	ln -s "${DISTDIR}"/9C98C277CFFBB4CA06CAFD5820562EF7B5100F5C-org.eclipse.core.runtime.compatibility.auth-3.2.200.jar o.eclipse.core.runtime.compatibility.auth/external/org.eclipse.core.runtime.compatibility.auth-3.2.200.jar || die
	ln -s "${DISTDIR}"/8A288BD66E90B1081F843A17F95973514ED55A97-org.eclipse.equinox.app-1.3.1.jar o.eclipse.equinox.app/external/org.eclipse.equinox.app-1.3.1.jar || die
	ln -s "${DISTDIR}"/491025C38F84A6FF9823315A74A0CAC4C30E51A8-org.eclipse.equinox.common-3.6.0.jar o.eclipse.equinox.common/external/org.eclipse.equinox.common-3.6.0.jar || die
	ln -s "${DISTDIR}"/F411AB988320260361C3611714CA5AF1480CD1A3-org.eclipse.equinox.preferences-3.3.0.jar o.eclipse.equinox.preferences/external/org.eclipse.equinox.preferences-3.3.0.jar || die
	ln -s "${DISTDIR}"/AD19FF36B5D976E5B4F289B5ACB32967216C1B2D-org.eclipse.equinox.registry-3.5.0.jar o.eclipse.equinox.registry/external/org.eclipse.equinox.registry-3.5.0.jar || die
	ln -s "${DISTDIR}"/1FE453D0B251571463F9BE4F51F413BBA5A376A7-org.eclipse.equinox.security-1.0.200.jar o.eclipse.equinox.security/external/org.eclipse.equinox.security-1.0.200.jar || die
	ln -s "${DISTDIR}"/34E70691382D67EE5C84EF207FB8D3784594BA2C-org.eclipse.jgit-1.0.0.201106090707-r.jar o.eclipse.jgit/external/org.eclipse.jgit-1.0.0.201106090707-r.jar || die
	ln -s "${DISTDIR}"/6AC191F42860D1698C9268AE044AFAA5FE806CE7-org.eclipse.mylyn.bugzilla.core-3.6.0.jar o.eclipse.mylyn.bugzilla.core/external/org.eclipse.mylyn.bugzilla.core-3.6.0.jar || die
	ln -s "${DISTDIR}"/4617423828BC2E79A1871949C2914285405D8EFF-org.eclipse.mylyn.commons.core-3.6.0.jar o.eclipse.mylyn.commons.core/external/org.eclipse.mylyn.commons.core-3.6.0.jar || die
	ln -s "${DISTDIR}"/053602E0177D42BF707019F1BC646193A899D571-org.eclipse.mylyn.commons.net-3.6.0.jar o.eclipse.mylyn.commons.net/external/org.eclipse.mylyn.commons.net-3.6.0.jar || die
	ln -s "${DISTDIR}"/032EFC784E1DE21E4093C08F336C7582F5694760-org.eclipse.mylyn.commons.xmlrpc-3.6.0.jar o.eclipse.mylyn.commons.xmlrpc/external/org.eclipse.mylyn.commons.xmlrpc-3.6.0.jar || die
	ln -s "${DISTDIR}"/5D73EEAEABC42C6FCB85593D1F5B04ACBDFAA0F9-org.eclipse.mylyn.tasks.core-3.6.0.jar o.eclipse.mylyn.tasks.core/external/org.eclipse.mylyn.tasks.core-3.6.0.jar || die
	ln -s "${DISTDIR}"/CD33537FD47E801E01B427997F3DE4016159B414-preindexed.zip javascript.editing/external/preindexed.zip || die
	ln -s "${DISTDIR}"/E66876EB5F33AA0E57F035F1AADD8C44FEAE7FCB-processtreekiller-1.0.1.jar extexecution.destroy/external/processtreekiller-1.0.1.jar || die
	ln -s "${DISTDIR}"/B0D0FCBAC68826D2AFA3C7C89FC4D57B95A000C3-resolver-1.2.jar o.apache.xml.resolver/external/resolver-1.2.jar || die
	ln -s "${DISTDIR}"/1162833E0FE87B69B99B1F7DEB3A6C386EAB6F84-rhino1_7R2rc1.zip o.mozilla.rhino.patched/external/rhino1_7R2rc1.zip || die
	ln -s "${DISTDIR}"/C56F4F5C42102A67F56EB8F12D0219E92E5307C2-sdocs.zip javascript.editing/external/sdocs.zip || die
	ln -s "${DISTDIR}"/538D727A9A0874019FB11280F07CE3F43EE723BC-sqljet-1.0.3.jar libs.svnClientAdapter.svnkit/external/sqljet-1.0.3.jar || die
	ln -s "${DISTDIR}"/0B9606F570B28FFC4FCE6C7222B88B3DCEFB1A36-svnClientAdapter-javahl-1.6.13.jar libs.svnClientAdapter.javahl/external/svnClientAdapter-javahl-1.6.13.jar || die
	ln -s "${DISTDIR}"/A11623D2AF72A99C1509EC2A0ADA2DACBEE9A8E4-svnClientAdapter-main-1.6.13.jar libs.svnClientAdapter/external/svnClientAdapter-main-1.6.13.jar || die
	ln -s "${DISTDIR}"/0AE20EC02958F193ADAB4C272ACCF6FE3196DCA0-svnClientAdapter-svnkit-1.6.13.jar libs.svnClientAdapter.svnkit/external/svnClientAdapter-svnkit-1.6.13.jar || die
	ln -s "${DISTDIR}"/636C6FF256A978B786D7502F43E788448E9DAB4B-svnkit-1.3.4.jar libs.svnClientAdapter.svnkit/external/svnkit-1.3.4.jar || die
	ln -s "${DISTDIR}"/AB271CFC19469D9088BE306685A7AC8787373F99-svnkit-javahl.jar libs.svnClientAdapter.svnkit/external/svnkit-javahl.jar || die
	ln -s "${DISTDIR}"/7C6ED64C55164C5AE0394E11303CA95CB24166AF-swingx-0.9.5.jar libs.swingx/external/swingx-0.9.5.jar || die
	ln -s "${DISTDIR}"/CD5B5996B46CB8D96C8F0F89A7A734B3C01F3DF7-tomcat-webserver-3.2.jar httpserver/external/tomcat-webserver-3.2.jar || die
	ln -s "${DISTDIR}"/68B82D7246FD90E0FC70BB9C8F10611489BF371A-trilead.jar libs.svnClientAdapter.svnkit/external/trilead.jar || die
	ln -s "${DISTDIR}"/55CD0B272084EB80B8C91F3A0617BB602B4EF2DF-ValidationAPI.jar swing.validation/external/ValidationAPI.jar || die
	ln -s "${DISTDIR}"/7A5A7DF07297A86A944D4D0562C685585B0734EF-validator.jar html.validation/external/validator.jar || die
	ln -s "${DISTDIR}"/C9757EFB2CFBA523A7375A78FA9ECFAF0D0AC505-winp-1.14-patched.jar extexecution.destroy/external/winp-1.14-patched.jar || die
	ln -s "${DISTDIR}"/64F5BEEADD2A239C4BC354B8DFDB97CF7FDD9983-xmlrpc-client-3.0.jar o.apache.xmlrpc/external/xmlrpc-client-3.0.jar || die
	ln -s "${DISTDIR}"/8FA16AD28B5E79A7CD52B8B72985B0AE8CCD6ADF-xmlrpc-common-3.0.jar o.apache.xmlrpc/external/xmlrpc-common-3.0.jar || die
	ln -s "${DISTDIR}"/D6917BF718583002CBE44E773EE21E2DF08ADC71-xmlrpc-server-3.0.jar o.apache.xmlrpc/external/xmlrpc-server-3.0.jar || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-9999-r1-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS9999_PATCHES_DIR}" -a -d "${NETBEANS9999_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS9999_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	popd >/dev/null || die

	java-pkg_jar-from --build-only --into c.jcraft.jsch/external jsch jsch.jar jsch-0.1.44.jar
	java-pkg_jar-from --build-only --into c.jcraft.jzlib/external jzlib jzlib.jar jzlib-1.0.7.jar
	java-pkg_jar-from --into db.drivers/external jdbc-mysql jdbc-mysql.jar mysql-connector-java-5.1.13-bin.jar
	java-pkg_jar-from --into db.drivers/external jdbc-postgresql jdbc-postgresql.jar postgresql-8.3-603.jdbc3.jar
	java-pkg_jar-from --build-only --into db.sql.visualeditor/external javacc javacc.jar javacc-3.2.jar
	java-pkg_jar-from --into extexecution.destroy/external commons-io-1 commons-io.jar commons-io-1.4.jar
	java-pkg_jar-from --into html.parser/external icu4j-4.4 icu4j.jar icu4j-4_0.jar
	java-pkg_jar-from --into html.validation/external commons-logging commons-logging.jar commons-logging-1.1.1.jar
	java-pkg_jar-from --into html.validation/external commons-logging commons-logging-api.jar commons-logging-api-1.1.1.jar
	# java-pkg_jar-from --into html.validation/external jing jing.jar jing.jar
	java-pkg_jar-from --into html.validation/external log4j log4j.jar log4j-1.2.15.jar
	java-pkg_jar-from --into html.validation/external saxon-9 saxon.jar saxon9B.jar
	# java-pkg_jar-from --into libs.antlr3.runtime/external antlr-3 antlr3.jar antlr-runtime-3.1.3.jar
	# java-pkg_jar-from --into libs.commons_net/external commons-net commons-net.jar commons-net-1.4.1.jar
	java-pkg_jar-from --into libs.freemarker/external freemarker-2.3 freemarker.jar freemarker-2.3.8.jar
	# java-pkg_jar-from --into libs.ini4j/external ini4j ini4j.jar ini4j-0.5.1.jar
	# java-pkg_jar-from --into libs.jaxb/external jaxb-2 jaxb-impl.jar jaxb-impl.jar
	java-pkg_jar-from --into libs.jvyamlb/external jvyamlb jvyamlb.jar jvyamlb-0.2.3.jar
	java-pkg_jar-from --into libs.lucene/external lucene-3.0 lucene-core.jar lucene-core-3.0.3.jar
	java-pkg_jar-from --into libs.smack/external smack-2.2 smack.jar smack.jar
	java-pkg_jar-from --into libs.smack/external smack-2.2 smackx.jar smackx.jar
	java-pkg_jar-from --into libs.svnClientAdapter.javahl/external subversion svn-javahl.jar svnjavahl-1.6.0.jar
	# java-pkg_jar-from --into libs.svnClientAdapter.svnkit/external trilead-ssh2 trilead-ssh2.jar trilead.jar
	java-pkg_jar-from --into libs.xerces/external xerces-2 xercesImpl.jar xerces-2.8.0.jar
	java-pkg_jar-from --build-only --into o.apache.commons.codec/external commons-codec commons-codec.jar apache-commons-codec-1.3.jar
	java-pkg_jar-from --into o.apache.commons.httpclient/external commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.1.jar
	java-pkg_jar-from --into o.apache.commons.lang/external commons-lang-2.1 commons-lang.jar commons-lang-2.4.jar
	java-pkg_jar-from --into o.apache.commons.logging/external commons-logging commons-logging.jar commons-logging-1.1.jar
	java-pkg_jar-from --into o.apache.ws.commons.util/external ws-commons-util ws-commons-util.jar ws-commons-util-1.0.1.jar
	java-pkg_jar-from --into servletapi/external tomcat-servlet-api-2.2 servlet.jar servlet-2.2.jar
	java-pkg_jar-from --into xml.jaxb.api/external sun-jaf activation.jar activation.jar
	# java-pkg_jar-from --into xml.jaxb.api/external jaxb-2 jaxb-api.jar jaxb-api.jar
	java-pkg_jar-from --into xml.jaxb.api/external jsr173 jsr173.jar jsr173_api.jar

	java-pkg-2_src_prepare
}

src_compile() {
	unset DISPLAY
	eant -f ${EANT_BUILD_XML} ${EANT_EXTRA_ARGS} ${EANT_BUILD_TARGET} || die "Compilation failed"
}

src_install() {
	pushd nbbuild/netbeans/ide >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/ide$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *
	rm -fr "${D}"/${INSTALL_DIR}/bin/nativeexecution || die
	rm -fr "${D}"/${INSTALL_DIR}/modules/lib || die

	insinto ${INSTALL_DIR}/bin/nativeexecution
	doins bin/nativeexecution/*

	pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution >/dev/null || die
	for file in *.sh ; do
		fperms 755 ${file}
	done
	popd >/dev/null || die

	if use x86 ; then
		doins -r bin/nativeexecution/Linux-x86
		pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution/Linux-x86 >/dev/null || die
		for file in * ; do
			fperms 755 ${file}
		done
		popd >/dev/null || die
	elif use amd64 ; then
		doins -r bin/nativeexecution/Linux-x86_64
		pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution/Linux-x86_64 >/dev/null || die
		for file in * ; do
			fperms 755 ${file}
		done
		popd >/dev/null || die
	fi

	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	# rm antlr-runtime-3.1.3.jar && dosym /usr/share/antlr-3/lib/antlr3.jar ${instdir}/antlr-runtime-3.1.3.jar || die
	# bytelist-0.1.jar
	rm commons-logging-api-1.1.1.jar && dosym /usr/share/commons-logging/lib/commons-logging-api.jar ${instdir}/commons-logging-api-1.1.1.jar || die
	rm commons-logging-1.1.1.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging-1.1.1.jar || die
	# rm commons-net-1.4.1.jar && dosym /usr/share/commons-net/lib/commons-net.jar ${instdir}/commons-net-1.4.1.jar || die
	# ddl.jar
	rm freemarker-2.3.8.jar && dosym /usr/share/freemarker-2.3/lib/freemarker.jar ${instdir}/freemarker-2.3.8.jar || die
	# html5-datatypes.jar
	# html5-parser.jar
	rm icu4j-4_0.jar && dosym /usr/share/icu4j-4.4/lib/icu4j.jar ${instdir}/icu4j-4_0.jar || die
	# [[ -f ini4j-0.5.1.jar ]] && java-pkg_jar-from ini4j ini4j.jar ${instdir}/ini4j-0.5.1.jar || die
	# io-xml-util.jar
	# iri.jar
	# isorelax20041111.jar
	# [[ -f jing.jar ]] && java-pkg_jar-from jing jing.jar ${instdir}/jing.jar || die
	# js.jar
	rm jvyamlb-0.2.3.jar && dosym /usr/share/jvyamlb/lib/jvyamlb.jar ${instdir}/jvyamlb-0.2.3.jar || die
	# libpam4j-1.1.jar
	rm log4j-1.2.15.jar && dosym /usr/share/log4j/lib/log4j.jar ${instdir}/log4j-1.2.15.jar || die
	rm lucene-core-3.0.3.jar && dosym /usr/share/lucene-3.0/lib/lucene-core.jar ${instdir}/lucene-core-3.0.3.jar || die
	rm mysql-connector-java-5.1.13-bin.jar && dosym /usr/share/jdbc-mysql/lib/jdbc-mysql.jar ${instdir}/mysql-connector-java-5.1.13-bin.jar || die
	# non-schema.jar
	# org.eclipse.mylyn.bugzilla.core_3.3.1.jar
	# org.eclipse.mylyn.commons.core_3.3.1.jar
	# org.eclipse.mylyn.commons.net_3.3.0.jar
	# org.eclipse.mylyn.tasks.core_3.3.1.jar
	# org-netbeans-tax.jar
	rm postgresql-8.3-603.jdbc3.jar && dosym /usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar ${instdir}/postgresql-8.3-603.jdbc3.jar || die
	# processtreekiller-1.0.1.jar
	# resolver-1.2.jar
	rm saxon9B.jar && dosym /usr/share/saxon-9/lib/saxon.jar ${instdir}/saxon9B.jar || die
	rm servlet-2.2.jar && dosym /usr/share/tomcat-servlet-api-2.2/lib/servlet.jar ${instdir}/servlet-2.2.jar || die
	rm smack.jar && dosym /usr/share/smack-2.2/lib/smack.jar ${instdir}/smack.jar || die
	rm smackx.jar && dosym /usr/share/smack-2.2/lib/smackx.jar ${instdir}/smackx.jar || die
	# sqljet-1.0.3.jar
	# svnClientAdapter-javahl-1.6.13.jar
	# svnClientAdapter-main-1.6.13.jar
	# svnClientAdapter-svnkit-1.6.13.jar
	rm svnjavahl-1.6.0.jar && dosym /usr/share/subversion/lib/svn-javahl.jar ${instdir}/svnjavahl-1.6.0.jar || die
	# svnkit-javahl.jar
	# svnkit-1.3.4.jar
	# swingx-0.9.5.jar
	# [[ -f trilead.jar ]] && java-pkg_jar-from trilead-ssh2 trilead-ssh2.jar ${instdir}/trilead.jar || die
	# ValidationAPI.jar
	# validator.jar
	# webserver.jar
	# winp-1.14-patched.jar
	rm xerces-2.8.0.jar && dosym /usr/share/xerces-2/lib/xercesImpl.jar ${instdir}/xerces-2.8.0.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxb
	pushd "${D}"/${instdir} >/dev/null || die
	rm activation.jar && dosym /usr/share/sun-jaf/lib/activation.jar ${instdir}/activation.jar || die
	# [[ -f jaxb-impl.jar ]] && java-pkg_jar-from jaxb-2 jaxb-impl.jar ${instdir}/jaxb-impl.jar || die
	# jaxb-xjc.jar
	# jaxb1-impl.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxb/api
	pushd "${D}"/${instdir} >/dev/null || die
	# [[ -f jaxb-api.jar ]] && java-pkg_jar-from jaxb-2 jaxb-api.jar ${instdir}/jaxb-api.jar || die
	rm jsr173_api.jar && dosym /usr/share/jsr173/lib/jsr173.jar ${instdir}/jsr173_api.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/ide
}
