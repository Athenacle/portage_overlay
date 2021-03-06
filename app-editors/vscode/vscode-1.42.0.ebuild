# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Multiplatform Editor Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? (  https://go.microsoft.com/fwlink/?LinkID=620884 -> ${P}-amd64-${PV}.tar.gz )
	"
RESTRICT="mirror"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46:*
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
"

RDEPEND="${DEPEND}"


src_unpack(){
	S="${WORKDIR}/VSCode-linux-x64"
	default
}

src_install(){
	insinto "/opt/athenacle/${PN}"
	doins -r *
	dosym "/opt/athenacle/${PN}/code" "/opt/bin/code"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.svg"
	fperms +x "/opt/athenacle/${PN}/code"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
	elog "Code is Multiplatform Editor Visual Studio Code from Microsoft"
	elog "This is a Athenacle Overlay."
}
