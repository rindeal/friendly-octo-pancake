# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.3.2.1-r1.ebuild,v 1.4 2002/08/22 19:35:19 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"
DEPEND=">=dev-lang/python-2.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	x11-libs/wxGTK"
	#opengl? ( virtual/opengl )"
	#really need opengl? ( virtual/opengl dev-python/PyOpenGL )
	#to get full opengl functionality, i.e. wxGLCanvas.

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
#	local myconf
#	myconf=""
#
#	if use opengl; then
#		myconf="${myconf} BUILD_GLCANVAS=1"
#	else
#		myconf="${myconf} BUILD_GLCANVAS=0"
#	fi
        
#Other possible configuration variables are BUILD_OGL and BUILD_STC.
#BUILD_OGL builds the Object Graphics Library extension module.
#BUILD_STC builds the wxStyledTextCtrl (the Scintilla wrapper) extension module.
#Both these variable are enabled by default.  To disable them set equal to zero
#and add to myconf.

	# this doesn't work yet with opengl, thus,
	# force the issue for now.
	# It *builds* but sigsegs at runtime.
	# myconf="BUILD_GLCANVAS=0"
	cd ${S}
	patch -p1 < ${FILESDIR}/noglcanvas.diff || die "patch failed"

	# gizmos currently fails compiling on gcc3
	# myconf="${myconf} BUILD_GIZMOS=0"
	patch -p1 < ${FILESDIR}/nogizmos.diff || die "patch failed"

	python setup.py build || die
}

src_install () {
	python setup.py install --prefix=${D}/usr || die

	dodoc BUILD.unix.txt CHANGES.txt MANIFEST.in PKG-INFO README.txt
}
