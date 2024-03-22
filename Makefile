PORTNAME=				irrlichtMt
DISTVERSION=			g20240321
CATEGORIES=				x11-toolkits graphics
DISTNAME=				${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=			${PORTNAME}

MAINTAINER=				nope@nothere
COMMENT=				High performance realtime 3D engine - minetest fork

LICENSE=				ZLIB

BUILD_DEPENDS=			${LOCALBASE}/include/glm/glm.hpp:math/glm
LIB_DEPENDS=			libpng.so:graphics/png #\
#						libOpenGL.so:graphics/libglvnd

# match the requirement for minetest compiler features.
USES=					alias cmake dos2unix jpeg gl xorg sdl llvm:min=16 pkgconfig:build
#USES=					alias cmake compiler:c++20-lang dos2unix jpeg gl xorg sdl
DOS2UNIX_GLOB=			*.cpp *.h *.txt Makefile
USE_GITHUB=				nodefault
GH_ACCOUNT=				minetest
GH_PROJECT=				irrlicht
GH_TAGNAME=				124708784fdc4321d5983cdbfb889e62fbd25f40
USE_GL=					glu egl
USE_LDCONFIG=			yes
USE_SDL=				sdl2 ttf2
USE_XORG=				x11 xxf86vm xcb xext xau xdmcp


CMAKE_ARGS=				-DCMAKE_BUILD_TYPE="MinSizeRel" \
						-DCUSTOM_MANDIR="${PREFIX}/man" \
						-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
						-DWARN_ALL="TRUE" \
						-DBUILD_SHARED_LIBS="ON" \
						-DUSE_SDL2="ON"

CXXFLAGS+=				$$(freetype-config --cflags)

WRKSRC=					${WRKDIR}/irrlicht-${GH_TAGNAME}

OPTIONS_DEFINE=			EXAMPLES
#OPTIONS_DEFINE=		EXAMPLES XCURSOR XINPUT
OPTIONS_DEFAULT=		OPENGL
#OPTIONS_DEFAULT=		OPENGL XINPUT
OPTIONS_SINGLE=			GRAPHICS

OPTIONS_SINGLE_GRAPHICS=GLES1 GLES2 OPENGL OPENGL3

EXAMPLES_DESC=			Build and install examples
GLES1_DESC=				Enable GLES1 (testing)
GLES2_DESC=				Enable GLES2 (testing)
OPENGL3_DESC=			Support OPENGL3 --Builds but seems incomplete--
OPENGL_DESC=			Support OPENGL (<3.x)
#XCURSOR_DESC=			Use xcursor
#XINPUT_DESC=			Use xinput

EXAMPLES_CMAKE_BOOL=	BUILD_EXAMPLES
GLES1_USE=				GL+=glesv1
GLES1_CMAKE_BOOL=		ENABLE_GLES1
GLES2_USE=				GL+=glesv2
GLES2_CMAKE_BOOL=		ENABLE_GLES2
OPENGL3_USE=			GL+=gl
OPENGL3_CMAKE_BOOL=		ENABLE_OPENGL3
OPENGL_USE=				GL+=gl
OPENGL_CMAKE_BOOL=		ENABLE_OPENGL
#XCURSOR_USE=			XORG+=xcursor
#XCURSOR_CMAKE_BOOL=	USE_XCURSOR
#XINPUT_USE=			XORG+=xi
#XINPUT_CMAKE_BOOL=		USE_XINPUT2

# If we had two versions of OpenGL available, this would matter more.

# Our version of OpenGL was 3.2 as of 2016 but this does not yet build.
# Their default *hid behind* SDL2, the actual difference within irrlichtMt is unknown.
# https://github.com/minetest/irrlicht/commit/b89455f3851e372b93acba4eb2162635aa2301b5

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
#ENABLE_OPENGL3:BOOL=ON
#SDL2_DIR:PATH=/usr/local/lib/cmake/SDL2
#USE_SDL2:BOOL=ON
#----
#Warning: you might not need LIB_DEPENDS on libpng.so
#Warning: you might not need LIB_DEPENDS on libEGL.so
#Warning: you might not need LIB_DEPENDS on libSDL2.so
#Warning: you might not need LIB_DEPENDS on libSDL2_ttf.so
#----
# These seem to have been removed inthis current version.
#ENABLE_WEBGL1:BOOL=OFF
#USE_X11:BOOL=ON
#USE_XCURSOR:BOOL=OFF
#USE_XINPUT2:BOOL=ON
# -DUSE_X11="ON" \
# Although sdl seems to be an option for building, leaving it out causes the build to fail.

.include <bsd.port.mk>
