PORTNAME=	irrlichtMt
DISTVERSION=	g20230326
CATEGORIES=	x11-toolkits graphics
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	nope@nothere
COMMENT=	High performance realtime 3D engine - minetest fork

LICENSE=	ZLIB

LIB_DEPENDS=	libpng.so:graphics/png

USES=		alias cmake compiler:c11 dos2unix jpeg gl xorg

DOS2UNIX_GLOB=	*.cpp *.h *.txt Makefile

USE_GITHUB=	nodefault
GH_ACCOUNT=	minetest
GH_PROJECT=	irrlicht
GH_TAGNAME=	ba1cd19983f9a5d6824aa0fcf0714bc102699cc9

CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_GL_PREFERENCE=GLVND \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DOPENGL_egl_LIBRARY="${PREFIX}/include/GLES"

USE_GL=		gl glu egl glesv2
USE_XORG=	x11 xxf86vm xcb xext xau xdmcp xi
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-${GH_TAGNAME}

#OPTIONS_DEFINE= EXAMPLES
#
#EXAMPLES_CMAKE_BOOL=	BUILD_EXAMPLES
#Provided in directory below, right after make (prior to install), so need more mechanism to build and install them
#x11-toolkits/irrlicht-minetest/work/irrlicht-master/examples
#
#valid arguments are:
#c++11-lib c++11-lang c++14-lang c++17-lang c11 features openmp env nestedfct c++0x gcc-c++11-lib
#
#----
#BUILD_EXAMPLES:BOOL=OFF
#BUILD_SHARED_LIBS:BOOL=ON
#CMAKE_BUILD_TYPE:STRING=Release
#CMAKE_INSTALL_PREFIX:PATH=/usr/local
#ENABLE_GLES1:BOOL=OFF
#ENABLE_GLES2:BOOL=OFF
#ENABLE_OPENGL:BOOL=ON
#ENABLE_WEBGL1:BOOL=OFF
#USE_SDL2:BOOL=OFF
#USE_X11:BOOL=ON
#USE_XCURSOR:BOOL=OFF
#USE_XINPUT2:BOOL=ON

.include <bsd.port.mk>
