# Created by: nobody
# $FreeBSD$

PORTNAME=	irrlichtMt
DISTVERSION=	g20210402
CATEGORIES=	x11-toolkits graphics
MASTER_SITES=	https://github.com/minetest/irrlicht/archive/refs/heads/
DISTNAME=	master
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	nope@nothere
COMMENT=	High performance realtime 3D engine - minetest fork

LICENSE=	ZLIB

LIB_DEPENDS=	libpng.so:graphics/png

USES=		alias cmake compiler:c11 dos2unix gl jpeg xorg zip

DOS2UNIX_GLOB=	*.cpp *.h *.txt Makefile

USE_GITHUB=	nodefault
GH_ACCOUNT=	minetest
GH_PROJECT=	minetest
GH_TAGNAME=	c77797bbed45d19b3d73fb1bb8a73ac7be0ad709

USE_GL=		gl
USE_XORG=	x11 xxf86vm
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-master

.include <bsd.port.mk>
