# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.0.0_pre8-r1.ebuild,v 1.3 2004/05/10 21:10:21 karltk Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/S-3.0M8-200403261517/eclipse-sourceBuild-srcIncluded-3.0M8.zip"
IUSE="gtk motif gnome kde mozilla jikes"
SLOT="3"
LICENSE="CPL-1.0"
KEYWORDS="~x86"

RDEPEND=">=virtual/jdk-1.3
	|| (
		gtk? ( >=x11-libs/gtk+-2.2.4 )
		kde? ( kde-base/kdelibs x11-libs/openmotif )
		motif? ( x11-libs/openmotif )
		>=x11-libs/gtk+-2.2.4
		)
	mozilla? ( >=net-www/mozilla-1.5 )
	gnome? ( =gnome-base/gnome-vfs-2* )
	"

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11
	app-arch/unzip"

pkg_setup() {
	ewarn "This package is _highly_ experimental."
	ewarn "If you are using Eclipse 2.1.x for any serious work, stop now."
	ewarn "You cannot expect to be productive with this packaging of 3.0!"
}

set_dirs() {
	gtk_launcher_src_dir="plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="plugins/platform-launcher/library/motif"
	gtk_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/gtk/library"
	motif_swt_src_dir="plugins/org.eclipse.swt/Eclipse SWT PI/motif/library"

	core_src_dir="plugins/org.eclipse.core.resources.linux/src"

	case $ARCH in
		sparc)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/solaris/sparc"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/solaris/sparc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/solaris/sparc"
			;;
		x86)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/x86"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/x86"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/x86"
			;;
		ppc)
			gtk_swt_dest_dir="plugins/org.eclipse.swt.gtk/os/linux/ppc"
			motif_swt_dest_dir="plugins/org.eclipse.swt.motif/os/linux/ppc"
			core_dest_dir="plugins/org.eclipse.core.resources.linux/os/linux/ppc/"
			;;
	esac
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	# karltk: Is this really needed?
	addwrite "/proc/self/maps"

	# Clean up all pre-built code
	ant -q -DinstallWs=gtk -DinstallOs=linux clean
	ant -q -DinstallWs=motif -DinstallOs=linux clean
	find ${S} -name '*.so' -exec rm -f {} \;
	find ${S} -name '*.so.*' -exec rm -f {} \;
	find ${S} -type f -name 'eclipse' -exec rm {} \;
	rm -f eclipse

	# Load environment varis for various directories
	set_dirs

	# Move around some source code that should have been handled by the build system
	cd ${S}/"${gtk_swt_src_dir}" || die "Directory ${gtk_swt_src_dir} not found"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Mozilla/common/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ Program/gnome/library/* .
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT\ AWT/gtk/library/* .

	if use gnome ; then
	    gnome_lib=`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	fi

	if use gtk ; then
		gtk_lib=`pkg-config --libs gtk+-2.0 gthread-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
		atk_lib=`pkg-config --libs atk gtk+-2.0 | sed -e "s:-Wl,--export:--export:"`
	fi

	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/jdk1.5.0:$JAVA_HOME:" \
		-e "s:/mozilla/mozilla/1.6/linux_gtk2/mozilla/dist:$MOZILLA_FIVE_HOME:" \
		-e "s:/usr/lib/mozilla-1.6:$MOZILLA_FIVE_HOME:" \
		-e "s:\`pkg-config --libs gtk+-2.0 gthread-2.0\`:${gtk_lib}:" \
		-e "s:\`pkg-config --libs atk gtk+-2.0\`:${atk_lib}:" \
		-e "s:\`pkg-config --libs gnome-vfs-module-2.0 libgnome-2.0 libgnomeui-2.0\`:${gnome_lib}:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME):" \
		-e "s:MOZILLACFLAGS = -O:MOZILLACFLAGS = -O -fPIC:" \
		-e "s:\$(JAVA_HOME)/jre/bin:\$(JAVA_HOME)/jre/lib/i386:" \
		-i make_gtk.mak

	# Extra patching if the gtk+ installed is 2.4 or newer
	# for users with the 2.3 series, they should upgrade, dunno which 2.3.x all this
	#  stuff broke in anyway.
	if pkg-config --atleast-version 2.4 gtk+-2.0 ; then
		einfo "Applying gtk+-2.4 patches"
		sed -r \
			-e "s:#define GTK_DISABLE_DEPRECATED::g" \
			-e "s:(^void gtk_progress_bar_set_bar_style.*):/* \1 */:" \
			-i os.h
	fi

	cd ${S}/"${motif_swt_src_dir}"
	cp ${S}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .
	sed -e "s:/bluebird/teamswt/swt-builddir/IBMJava2-141:$JAVA_HOME:" \
		-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
		-e "s:/usr/lib/qt-3.1:/usr/qt/3:" \
		-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
		-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
		-e "s:-I\$(JAVA_HOME)/include:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-I\$(JAVA_HOME)\t:-I\$(JAVA_HOME)/include -I\$(JAVA_HOME)/include/linux:" \
		-e "s:-L\$(MOZILLA_HOME)/lib -lembed_base_s:-L\$(MOZILLA_HOME):" \
		-e "s:-L\$(JAVA_HOME)/jre/bin:-L\$(JAVA_HOME)/jre/lib/i386:" \
		-i make_linux.mak

	cd ${S}
	find -type f -name about.mappings -exec sed -e "s/@build@/Gentoo Linux ${PV}/" -i \{\} \;
}

build_gtk_frontend() {

	einfo "Building gtk+ SWT"

	# Build the eclipse gtk binary
	cd ${S}/plugins/platform-launcher/library/gtk
	tcsh -f build.csh -output eclipse-gtk -arch $ARCH || die "Failed to build eclipse-gtk"

	cd ${S}/"${gtk_swt_src_dir}"
	make -f make_gtk.mak make_swt || die "Failed to build platform-independent SWT support"
	make -f make_gtk.mak make_atk || die "Failed to build atk support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		make -f make_gtk.mak make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		einfo "Building Mozilla component"
		make -f make_gtk.mak make_mozilla || die "Failed to build Mozilla support"
	fi

	# move the *.so files to the right path so eclipse can find them
	mkdir -p ${S}/"${gtk_swt_dest_dir}"
	mv *.so ${S}/"${gtk_swt_dest_dir}"
}

build_motif_frontend() {

	# Build eclipse motif binary
	cd ${S}/plugins/platform-launcher/library/motif
	tcsh -f build.csh -output eclipse-motif -arch $ARCH || die "Failed to build eclipse-motif"

	cd ${S}/"${motif_swt_src_dir}"

	make -f make_linux.mak make_swt || die "Failed to build Motif support"
	if use gnome ; then
		make -f make_linux.mak make_gnome || die "Failed to build GNOME VFS support"
	fi
	if use kde ; then
		make -f make_linux.mak make_kde || die "Failed to build KDE support"
	fi

	# move the *.so files to the right path so eclipse can find them
	mkdir -p ${S}/"${motif_swt_dest_dir}"
	mv *.so ${S}/"${motif_swt_dest_dir}"
}

src_compile() {

	addwrite "/proc/self/maps"

	# Figure out correct boot classpath
	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		# IBM JRE
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/core.jar"
	else
		# Sun derived JREs (Blackdown, Sun)
		ant_extra_opts="-Dbootclasspath=$(java-config --jdk-home)/jre/lib/rt.jar"
	fi

	if use jikes ; then
		ant_extra_opts="${ant_extra_opts} -Dbuild.compiler=jikes"
	fi

	export ANT_OPTS=-Xmx768m

	set_dirs

	# First build all java code


	if ( use gtk || ! ( use gtk || use motif || use kde ) ); then
		einfo "Building GTK+ frontend"
		ant -q \
			-buildfile build.xml \
			-DinstallOs=linux \
			-DinstallWs=gtk \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile || die "Failed to compile java code (gtk+)"
	fi
	if use motif ; then
		einfo "Building Motif frontend"
		ant -q \
			-buildfile build.xml \
			-DinstallOs=linux \
			-DinstallWs=motif \
			-DinstallArch=$ARCH \
			${ant_extra_opts} compile || die "Failed to compile java code (Motif)"
	fi

	einfo "Building resources.core plugin"
	cd ${core_src_dir}
	make JDK_INCLUDE="`java-config -O`/include -I`java-config -O`/include/linux" || die "Failed to build resource.core plugin"
	mkdir -p ${S}/"${core_dest_dir}"
	mv *.so ${S}/"${core_dest_dir}"

	cd ${S}

	# Build selected frontends
	use gtk && build_gtk_frontend
	use motif && build_motif_frontend

}

generate_filelist() {
	local findopts
	if [ "$1" == "dirs" ] ; then
		findopts="-type d"
	elif [ "$1" == "files" ] ; then
		findopts="-type f"
	else
		die "Incorrect param to generate_filelist"
	fi
	find plugins ${findopts} | \
		egrep -v ".*\.(java|c|h|o|mak)$" | \
		egrep -v "(/|\.)(carbon|solaris|win32|hpux|aix|photon|macosx|gtk64)" | \
		egrep -v ".*src.zip$" | \
		egrep -v "/src(-|_|new)" | \
		egrep -v "/src/" | \
		grep -v "build.xml"
}

src_install() {
	eclipse_dir="/usr/lib/eclipse-${SLOT}"

	# Create basic directories
	dodir ${eclipse_dir}
	insinto ${eclipse_dir}
	doins plugins/org.eclipse.platform/.eclipseproduct

	# Install features
	dodir ${eclipse_dir}/features
	einfo "Copying features"
	cp -dpR features/org.eclipse.{sdk,jdt,pde,platform} ${D}/${eclipse_dir}/features/

	# Install plugins
	einfo "Creating directory structure"
	generate_filelist dirs | xargs -n 1 -i@ dodir ${eclipse_dir}/@ || die "Failed to create plugin directory structure"
	einfo "Copying plugins"
	generate_filelist files | xargs -n 1 -i@ cp @ ${D}/${eclipse_dir}/@ || die "Failed to copy plugins"

	# Install launchers and native code
	if use gtk ; then
		einfo "Installing eclipse-gtk binary"
		mv  ${D}/${eclipse_dir}/plugins/platform-launcher/library/gtk/eclipse-gtk \
			${D}/${eclipse_dir}/eclipse-gtk || die "Failed to install eclipse-gtk"
	fi
	if use motif ; then
		einfo "Installing eclipse-motif binary"
		mv  ${D}/${eclipse_dir}/plugins/platform-launcher/library/motif/eclipse-motif \
			${D}/${eclipse_dir}/eclipse-motif || die "Failed to install eclipse-motif"
	fi

	doins plugins/org.eclipse.platform/{startup.jar,splash.bmp}
	doins plugins/platform-launcher/bin/linux/gtk/icon.xpm

	# Install startup script
	exeinto /usr/bin
	doexe ${FILESDIR}/eclipse-${SLOT}

	# Install GNOME .desktop file
	if use gnome ; then
		insinto /usr/share/gnome/apps/Development
		doins ${FILESDIR}/eclipse-${SLOT}.desktop
		sed -e "s/@PV@/${PV}/" -i ${D}/usr/share/gnome/apps/Development
	fi
}

# TODO
# - check MOZILLACFLAGS

