# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} pypy )

inherit distutils-r1 git-r3

DESCRIPTION="Personal Python Library."
HOMEPAGE="http://cgit.pi.slave.xyz"

EGIT_REPO_URI="git@192.168.1.2:/home/git/sandisk/gits/py-wxc.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

src_unpack(){
	git-r3_fetch ${EGIT_REPO_URI} v${PV}
	git-r3_checkout
}
