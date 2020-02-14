# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils git-r3

DESCRIPTION="Build EAR is a tool that generates a compilation database for clang tooling."
HOMEPAGE="https://github.com/rizsotto/Bear"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

CMAKE_MIN_VERSION=2.8
EGIT_REPO_URI="https://github.com/rizsotto/Bear.git"
EGIT_BRANCH="master"

DEPEND=""
RDEPEND="
	>=dev-lang/python-2.7:*
"

src_unpack(){
	git-r3_fetch ${EGIT_REPO_URI} ${PV}
	git-r3_checkout
}

