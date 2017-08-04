# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils  eutils unpacker

DESCRIPTION="A Missing Prototyping Tool for Mobile"
HOMEPAGE="https://modao.cc/"
SRC_URI="https://s3.cn-north-1.amazonaws.com.cn/modao/downloads/MockingBot_amd64.deb -> "${P}".deb"

LICENSE="mocking-bot"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/MockingBot.desktop"

DEPEND="
	gnome-base/gconf:2
	gnome-base/gvfs
	>=sys-libs/libcap-2.0
	dev-libs/libgcrypt:*
	x11-libs/gtk+:2
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack_deb "${P}.deb"
}


src_install() {
	dodir /
	cd "${WORKDIR}"/usr/lib/MockingBot
	fperms +x MockingBot
	fperms +x libnode.so 
	fperms +x libffmpeg.so
	cd "${WORKDIR}" || die
	doins -r *
}

pkg_preinst(){
	gnome2_icon_savelist
}


pkg_postrm() {
	gnome2_icon_cache_update
}

pkg_postinst() {
	gnome2_icon_cache_update
}
