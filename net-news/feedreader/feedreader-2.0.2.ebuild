# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils cmake-utils vala gnome2-utils fdo-mime

EGIT_REPO_URI="https://github.com/jangernert/FeedReader.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"

S="${EGIT_CHECKOUT_DIR}"
DESCRIPTION="Desktop application designed to complement existing web-based RSS accounts."
HOMEPAGE="http://jangernert.github.io/FeedReader/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	 app-crypt/libsecret[vala]
	 dev-lang/vala:*
	 x11-libs/gtk+:3
	 >=net-libs/libsoup-2.4
	 dev-libs/json-glib
	 net-libs/webkit-gtk:4
	 net-libs/libsoup:2.4
	 x11-libs/libnotify
	 dev-libs/libxml2
	 net-libs/rest
	 dev-libs/libgee:0.8
	 media-libs/gstreamer:1.0
	 >=net-libs/gnome-online-accounts-3.20
	 net-misc/curl
	 dev-libs/libpeas
	 media-libs/gst-plugins-base:*
	 dev-db/sqlite
"
RDEPEND="${DEPEND}"

src_unpack(){
	git-r3_fetch ${EGIT_REPO_URI} v${PV}
	git-r3_checkout
	egit_clean
}

src_prepare() {
	vala_src_prepare
	local vala_version=$(vala_best_api_version)
	sed -i -e "s/NAMES valac/NAMES valac-${vala_version}/" "${S}/cmake/FindVala.cmake" || die "sed: patch VALA search name failed."
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_LOCALINSTALL=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.svg"
	doicon "${FILESDIR}/${PN}.svg"
	elog "FeedReader is Desktop application designed to complement existing web-based RSS accounts"
	elog "Athenacle Personal Overlay."
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_schemas_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
