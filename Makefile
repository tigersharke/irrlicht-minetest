PORTNAME=	irrlichtMt
DISTVERSION=	g20220521
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
GH_TAGNAME=	128cf1696c2803e12ebbdd3ee034e0c9eea90fae

CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_GL_PREFERENCE=GLVND

USE_GL=		gl glu
USE_XORG=	x11 xxf86vm xcb xext xau xdmcp
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-${GH_TAGNAME}

#OPTIONS_DEFINE= EXAMPLES

#EXAMPLES_CMAKE_BOOL=	BUILD_EXAMPLES
#Provided in directory below, right after make (prior to install), so need more mechanism to build and install them
#x11-toolkits/irrlicht-minetest/work/irrlicht-master/examples

#valid arguments are:
#c++11-lib c++11-lang c++14-lang c++17-lang c11 features openmp env nestedfct c++0x gcc-c++11-lib

.include <bsd.port.mk>
