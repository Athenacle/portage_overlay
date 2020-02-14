# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils 

DESCRIPTION="A fast image processing library with low memory needs."
HOMEPAGE="https://github.com/jcupitt/libvips"
SRC_URI="https://github.com/jcupitt/libvips/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"
IUSE="+X +imagemagick doc debug  +jpeg exif +gif svg tiff fftw +png graphicsmagick orc webp lcms openexr pdf cfitsio gsf"

S="${WORKDIR}/libvips-${PV}"

RESTRICT=" mirror "

REUQIRED_USE="^^ ( imagemagick graphicsmagick )"

RDEPEND="
	cfitsio? ( sci-libs/cfitsio )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( || ( media-libs/jpeg:* media-libs/libjpeg-turbo ) )
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff:* )
	fftw? ( sci-libs/fftw:3 )
	png? ( media-libs/libpng:* )
	graphicsmagick? ( media-gfx/graphicsmagic )
	orc? ( dev-lang/orc )
	webp? ( media-libs/libwebp )
	openexr? ( media-libs/openexr )
	lcms? ( media-libs/lcms )
	pdf? ( app-text/poppler )
	gsf? ( >=gnome-extra/libgs-1.14.26 )
"

DEPEND="${RDEPEND}
		dev-libs/gobject-introspection
		dev-util/gtk-doc"

src_prepare(){
	eapply_user
	./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_with cfitsio)
		$(use_with tiff)
		$(use_with fftw)
		$(use_with png)
		$(use_with X)
		$(use_with lcms)
		$(use_with orc))

	myconf="${myconf} --with-zlib"
	if use X; then
		myconf="${myconf} --with-x"
	else
		myconf="${myconf} --without-x"
	fi

	if use openexr; then
		myconf="${myconf} --with-OpenEXR"
	else
		myconf="${myconf} --without-OpenEXR"
	fi

	 if use doc; then
		myconf="${myconf} --enable-gtk-doc --enable-gtk-doc-html --enable-gtk-doc-pdf "
	 fi

	 if use gif;  then
		 myconf="${myconf} --with-giflib"
	 else
		 myconf="${myconf} --without-giflib"
	 fi

	 if use svg; then
		 myconf="${myconf} --with-rsvg"
	 else
		 myconf="${myconf} --without-rsvg"
	 fi

	 if use pdf; then
		 myconf="${myconf} --with-poppler"
	 else
		 myconf="${myconf} --without-poppler"
	 fi

	 if use webp; then
		 myconf="${myconf} --with-libwebp"
	 else
		 myconf="${myconf} --without-libwebp"
	 fi

	 if use imagemagick; then
		 myconf="${myconf} --with-magickpackage=MagickCore"
	 else
		 if use graphicsmagick; then
			  myconf="${myconf} --with-magickpackage=GraphicsMagic"
		  else
			  myconf="${myconf} --without-magick"
		  fi
	 fi


	 myconf="${myconf} --enable-debug=$(usex debug yes no)"
	 econf ${myconf}
}
