# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="GitKraken is the Git client designed to make you a more productive Git user."
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="amd64? ( https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz -> ${P}.tar.gz )"
RESTRICT="mirror"

LICENSE="Gitkraken"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	>=gnome-base/gconf-2.0
	gnome-base/libgnome-keyring
	x11-libs/gtk+:2
	virtual/libudev
	dev-libs/libgcrypt:*
	x11-libs/libnotify
	x11-libs/libXtst
	>=dev-libs/nss-3.0
	dev-lang/python:*
	gnome-base/gvfs
	x11-misc/xdg-utils
"

RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}"

src_install(){
	insinto "/opt/athenacle/${PN}"
	doins -r *
	dosym "/opt/athenacle/${PN}/gitkraken" "/opt/bin/gitkraken"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.png"
	fperms +x "/opt/athenacle/${PN}/gitkraken"
	fperms +x "/opt/athenacle/${PN}/libffmpeg.so"
	fperms +x "/opt/athenacle/${PN}/libnode.so"
	insinto "/usr/share/licenses/${PN}"
}

pkg_postinst(){
	elog "GitKraken is the Git client designed to make you a more productive Git user"
	elog "Athenacle Personal Overlay."
}
