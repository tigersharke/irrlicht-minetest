# $FreeBSD$

PORTNAME=	irrlichtMt
DISTVERSION=	g20210409
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
GH_TAGNAME=	aa294a810782bb026957e0c38daf0825db9ac2f4

USE_GL=		gl
USE_XORG=	x11 xxf86vm
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/irrlicht-master

# FYI zlib is part of FreeBSD base
# https://www.freebsd.org/news/status/report-2019-07-2019-09/#Kernel-ZLIB-Update
#
# Notes from upstream readme
#    zlib, libPNG, libJPEG
#    OpenGL
#    or on mobile: OpenGL ES (can be optionally enabled on desktop too)
#    on Unix: X11
#--
#
# Periodically revisit:
# Since fork need to discover if dos2unix is still required as devs are linux oriented.
#
# Files created in DOS/Windows use carriage return (\r) and line feed (\n) for line endings.
# However, files in Unix/Linux solely use line feed.
#
.include <bsd.port.mk>
