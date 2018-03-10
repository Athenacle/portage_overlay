# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Postman is the most complete API Development Environment"
HOMEPAGE="https://www.getpostman.com"
SRC_URI="amd64? (  https://dl.pstmn.io/download/latest/linux64 -> "${P}".tar.gz )"
RESTRICT="mirror"

LICENSE="UNKNOWN"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Postman"
QA_PREBUILD="
Postman
libnode.so
libffmpeg.so
"
QA_PRESTRIPPED="${QA_PREBUILD}"


src_unpack(){
	default
	cd "${S}"/resources/app/assets/ || die
	mv icon.png postman-icon.png || die
}

src_install(){
	insinto "/opt/athenacle/${PN}"
	doins -r *
	dosym "/opt/athenacle/${PN}/Postman" "/opt/bin/postman"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
	insinto "/usr/share/pixmaps"
	doins "${S}"/resources/app/assets/postman-icon.png
	fperms +x "/opt/athenacle/${PN}/Postman"
}

