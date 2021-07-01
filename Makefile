PORTNAME=	irrlichtMt
DISTVERSION=	g20210630
CATEGORIES=	x11-toolkits graphics
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	nope@nothere
COMMENT=	High performance realtime 3D engine - minetest fork

LICENSE=	ZLIB

LIB_DEPENDS=	libpng.so:graphics/png

#USES=		alias cmake compiler:c11 dos2unix jpeg gl
USES=		alias cmake compiler:c11 dos2unix jpeg gl xorg

DOS2UNIX_GLOB=	*.cpp *.h *.txt Makefile

USE_GITHUB=	nodefault
GH_ACCOUNT=	minetest
GH_PROJECT=	irrlicht
GH_TAGNAME=	d62e0424f253dfd62fde93232452d8b377197191

CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_GL_PREFERENCE=GLVND

USE_GL=		gl glu
USE_XORG=	x11 xxf86vm
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-${GH_TAGNAME}

#OPTIONS_DEFINE= EXAMPLES

#EXAMPLES_CMAKE_BOOL=	BUILD_EXAMPLES
#Provided in directory below, right after make (prior to install), so need more mechanism to build and install them
#x11-toolkits/irrlicht-minetest/work/irrlicht-master/examples

.include <bsd.port.mk>
