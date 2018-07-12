# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.tar.gz -> atom-amd64-${PV}.tar.gz"

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 "
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
QA_PREBUILT="*"

S="${WORKDIR}/${P}-amd64"
src_install(){
	insinto "/opt/athenacle/${PN}"
	doins -r *
	dosym "/opt/athenacle/${PN}/${PN}" "/usr/bin/${PN}"
	dosym "/opt/athenacle/${PN}/resources/app/apm/bin/apm" "/usr/bin/apm"
	fperms +x "/opt/athenacle/${PN}/resources/app/apm/bin/apm"
	fperms +x "/opt/athenacle/${PN}/resources/app/apm/bin/node"
	fperms +x "/opt/athenacle/${PN}/resources/app/apm/bin/npm"
	fperms +x "/opt/athenacle/${PN}/resources/app/apm/bin/python-interceptor.sh"
	fperms +x "/opt/athenacle/${PN}/resources/app/atom.sh"
	fperms +x "/opt/athenacle/${PN}/${PN}"
	fperms +x "/opt/athenacle/${PN}/libnode.so"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
}
