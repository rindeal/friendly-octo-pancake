# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt4/PyQt4-4.5.4.ebuild,v 1.3 2009/08/02 05:19:41 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit python qt4

MY_P=PyQt-x11-gpl-${PV}
QTVER="4.5.1"

DESCRIPTION="A set of Python bindings for the Qt toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 GPL-3 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="X assistant +dbus debug doc examples kde opengl phonon sql svg webkit xmlpatterns"

DEPEND=">=dev-python/sip-4.8.2
	>=x11-libs/qt-core-${QTVER}:4
	>=x11-libs/qt-script-${QTVER}:4
	>=x11-libs/qt-test-${QTVER}:4
	X? ( >=x11-libs/qt-gui-${QTVER}:4[dbus?] )
	assistant? ( >=x11-libs/qt-assistant-${QTVER}:4 )
	dbus? (
		>=dev-python/dbus-python-0.80
		>=x11-libs/qt-dbus-${QTVER}:4
	)
	opengl? ( >=x11-libs/qt-opengl-${QTVER}:4 )
	phonon? (
		!kde? ( || ( >=x11-libs/qt-phonon-${QTVER}:4 media-sound/phonon ) )
		kde? ( media-sound/phonon )
	)
	sql? ( >=x11-libs/qt-sql-${QTVER}:4 )
	svg? ( >=x11-libs/qt-svg-${QTVER}:4 )
	webkit? ( >=x11-libs/qt-webkit-${QTVER}:4 )
	xmlpatterns? ( >=x11-libs/qt-xmlpatterns-${QTVER}:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/configure.py.patch"
)

pyqt4_use_enable() {
	use $1 && echo "--enable=${2:-$1}"
}

src_prepare() {
	if ! use dbus; then
		sed -i -e 's,^\([[:blank:]]\+\)check_dbus(),\1pass,' \
			"${S}"/configure.py || die
	fi
	qt4_src_prepare

	python_copy_sources

	prepare_package() {
		if [[ "${PYTHON_ABI:0:1}" == "3" ]]; then
			rm -fr pyuic/uic/port_v2
		else
			rm -fr pyuic/uic/port_v3
		fi
	}
	python_execute_function -s prepare_package
}

src_configure() {
	configure_package() {
		local myconf="$(get_python) configure.py
				--confirm-license
				--bindir=/usr/bin
				--destdir=$(python_get_sitedir)
				--sipdir=/usr/share/sip
				$(use debug && echo '--debug')
				--enable=QtCore
				--enable=QtNetwork
				--enable=QtScript
				--enable=QtTest
				--enable=QtXml
				$(pyqt4_use_enable X QtGui)
				$(pyqt4_use_enable X QtDesigner)
				$(pyqt4_use_enable assistant QtAssistant)
				$(pyqt4_use_enable assistant QtHelp)
				$(pyqt4_use_enable opengl QtOpenGL)
				$(pyqt4_use_enable phonon)
				$(pyqt4_use_enable sql QtSql)
				$(pyqt4_use_enable svg QtSvg)
				$(pyqt4_use_enable webkit QtWebKit)
				$(pyqt4_use_enable xmlpatterns QtXmlPatterns)"
		echo ${myconf}
		${myconf} || return 1

		# Fix insecure runpath.
		if use X ; then
			for pkg in QtDesigner QtGui QtCore; do
				sed -i -e "/^LFLAGS/s:-Wl,-rpath,${S}-${PYTHON_ABI}/qpy/${pkg}::" ${pkg}/Makefile || die "failed to fix rpath issues"
			done
		fi
	}
	python_execute_function -s configure_package
}

src_compile() {
	build_package() {
		emake
	}
	python_execute_function -s build_package
}

src_install() {
	python_need_rebuild

	install_package() {
		# INSTALL_ROOT is needed for the QtDesigner module,
		# the other Makefiles use DESTDIR.
		emake DESTDIR="${D}" INSTALL_ROOT="${D}" install
	}
	python_execute_function -s install_package

	dodoc ChangeLog NEWS THANKS || die

	if use doc; then
		dohtml -r doc/html/* || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}

pkg_postinst() {
	python_mod_optimize PyQt4
}

pkg_postrm() {
	python_mod_cleanup PyQt4
}
