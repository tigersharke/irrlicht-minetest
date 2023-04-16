PORTNAME=	irrlichtMt
DISTVERSION=	g20230415
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
GH_TAGNAME=	c4ab49201b128bbaf4d58f00d685faa6ee3cb2c1

CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DWARN_ALL="TRUE"

USE_GL=		glu egl
USE_XORG=	x11 xxf86vm xcb xext xau xdmcp xi
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-${GH_TAGNAME}

#OPTIONS_DEFINE= EXAMPLES
OPTIONS_DEFAULT= OPENGL
OPTIONS_RADIO=	GRAPHICS

OPTIONS_RADIO_GRAPHICS=	GLES1 GLES2 OPENGL WEBGL1 #SDL2

GLES1_DESC=	Enable GLES1 (broken?)
GLES1_CMAKE_BOOL=ENABLE_GLES1
GLES_USE=	GL+=glesv1

GLES2_DESC=	Enable GLES2 (broken?)
GLES2_CMAKE_BOOL=ENABLE_GLES2
GLES_USE=	GL+=glesv2

# If we had two versions of OpenGL available, this would matter.
OPENGL_DESC=	Enable OPENGL
OPENGL_CMAKE_BOOL=ENABLE_OPENGL
OPENGL_USE=	GL+=gl

# Our version of OpenGL was 3.2 as of 2016.
# Something is crossed-up with cmake or upstream config, expects sdl with opengl3
#OPENGL3_DESC=	Enable OPENGL3
#OPENGL3_CMAKE_BOOL=ENABLE_OPENGL3
#OPENGL3_USE=	GL+=gl

WEBGL1_DESC=	Enable WEBGL1 (incomplete)
WEBGL1_CMAKE_BOOL=ENABLE_WEBGL1

# Whoops, boolean in prior commit was wrong here.
#SDL2_DESC=	Enable SDL2
#SDL2_CMAKE_BOOL=USE_SDL2
#SDL2_USE=	sdl2
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
#ENABLE_OPENGL3:BOOL=OFF
#ENABLE_WEBGL1:BOOL=OFF
#USE_SDL2:BOOL=OFF
#USE_X11:BOOL=ON
#USE_XCURSOR:BOOL=OFF
#USE_XINPUT2:BOOL=ON

.include <bsd.port.mk>
