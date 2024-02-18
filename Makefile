PORTNAME=	irrlichtMt
DISTVERSION=	g20240216
CATEGORIES=	x11-toolkits graphics
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	nope@nothere
COMMENT=	High performance realtime 3D engine - minetest fork

LICENSE=	ZLIB

LIB_DEPENDS=	libpng.so:graphics/png #\
#		libOpenGL.so:graphics/libglvnd
BUILD_DEPENDS=	${LOCALBASE}/include/glm/glm.hpp:math/glm

# match the requirement for minetest compiler features.
USES=		alias cmake dos2unix jpeg gl xorg sdl llvm:min=16 pkgconfig:build
#USES=		alias cmake compiler:c++20-lang dos2unix jpeg gl xorg sdl

DOS2UNIX_GLOB=	*.cpp *.h *.txt Makefile

USE_GITHUB=	nodefault
GH_ACCOUNT=	minetest
GH_PROJECT=	irrlicht
GH_TAGNAME=	6ba6118b8cd3585867a6104b48ec5f1a8a46d9d1

CXXFLAGS +=	$$(freetype-config --cflags)
CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DWARN_ALL="TRUE" \
		-DBUILD_SHARED_LIBS="ON" \
		-DUSE_X11="ON" \
		-DUSE_SDL2="ON"

USE_GL=		glu egl
USE_SDL=	sdl2 ttf2
USE_XORG=	x11 xxf86vm xcb xext xau xdmcp
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-${GH_TAGNAME}

OPTIONS_DEFINE=		EXAMPLES XCURSOR XINPUT
OPTIONS_DEFAULT=	OPENGL XINPUT
OPTIONS_SINGLE=		GRAPHICS

OPTIONS_SINGLE_GRAPHICS=GLES1 GLES2 OPENGL OPENGL3 WEBGL1

GLES1_DESC=		Enable GLES1 (testing)
GLES1_CMAKE_BOOL=	ENABLE_GLES1
GLES_USE=		GL+=glesv1

GLES2_DESC=		Enable GLES2 (testing)
GLES2_CMAKE_BOOL=	ENABLE_GLES2
GLES_USE=		GL+=glesv2

# If we had two versions of OpenGL available, this would matter more.
OPENGL_DESC=		Support OPENGL (<3.x)
OPENGL_CMAKE_BOOL=	ENABLE_OPENGL
OPENGL_USE=		GL+=gl

# Our version of OpenGL was 3.2 as of 2016 but this does not yet build.
# Their default *hid behind* SDL2, the actual difference within irrlichtMt is unknown.
# https://github.com/minetest/irrlicht/commit/b89455f3851e372b93acba4eb2162635aa2301b5
OPENGL3_DESC=		Support OPENGL3 --Broken--
OPENGL3_CMAKE_BOOL=	ENABLE_OPENGL3
OPENGL3_USE=		GL+=gl

WEBGL1_DESC=		Enable WEBGL1 (testing)
WEBGL1_CMAKE_BOOL=	ENABLE_WEBGL1

XCURSOR_DESC=		Use xcursor
XCURSOR_CMAKE_BOOL=	USE_XCURSOR
XCURSOR_USE=		XORG+=xcursor

XINPUT_DESC=		Use xinput
XINPUT_CMAKE_BOOL=	USE_XINPUT2
XINPUT_USE=		XORG+=xi

EXAMPLES_DESC=		Build and install examples
EXAMPLES_CMAKE_BOOL=	BUILD_EXAMPLES
#Provided in directory below, right after make (prior to install), so need more mechanism to build and install them
#x11-toolkits/irrlicht-minetest/work/irrlicht-master/examples

pre-install:
	@${ECHO_MSG} " "
	@${ECHO_MSG} "-->   Options marked as testing may cause build to fail, may not function if built. "
	@${ECHO_MSG} " "

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
#
# Although sdl seems to be an option for building, leaving it out causes the build to fail.

.include <bsd.port.mk>
