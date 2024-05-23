# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake java-pkg-2

MY_PN="PollyMC"
FILESYSTEM_PV="1.5.14"

DESCRIPTION="DRM-free Prism Launcher fork with support for custom auth servers."
HOMEPAGE="https://github.com/fn2006/${MY_PV}"

SRC_URI="
	https://github.com/PrismLauncher/libnbtplusplus/archive/refs/heads/master.zip
		-> libnbtplusplus-master.zip
	https://github.com/gulrak/filesystem/archive/refs/tags/v${FILESYSTEM_PV}.tar.gz
		-> filesystem-${FILESYSTEM_PV}.tar.gz
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fn2006/${MY_PN}.git"
	EGIT_SUBMODULES=(libraries/libnbtplusplus libraries/filesystem)
else
	SRC_URI+="
		https://github.com/fn2006/${MY_PN}/archive/${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto qt5 qt6"

REQUIRED_USE="
	|| ( qt5 qt6 )
"

BDEPEND="
	app-arch/unzip
	kde-frameworks/extra-cmake-modules:0
	dev-build/cmake
	virtual/pkgconfig
	virtual/jre:*
"

RDEPEND="
	dev-cpp/tomlplusplus
	sys-libs/zlib
	app-text/cmark
	media-libs/glfw[X,wayland]
	media-libs/openal
	media-libs/libglvnd
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtsvg:5
		dev-qt/qtimageformats:5
		dev-libs/quazip[qt5(+)]
	)
	qt6? (
		dev-qt/qtbase:6
		dev-qt/qtsvg:6
		dev-qt/qt5compat:6
		dev-qt/qtimageformats:6
		dev-libs/quazip[qt6(+)]
	)
"

src_unpack() {
	default

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	else
		unpack libnbtplusplus-master.zip
		unpack "filesystem-${FILESYSTEM_PV}.tar.gz"
		rm -r "${S}/libraries/libnbtplusplus" && mv "${WORKDIR}/libnbtplusplus-master" "${S}/libraries/libnbtplusplus" || die
		rm -r "${S}/libraries/filesystem" && mv "${WORKDIR}/filesystem-${FILESYSTEM_PV}" "${S}/libraries/filesystem" || die
	fi
}

src_prepare() {
	default
	# replace all occurences of java "-target 7 -source 7" to "-target 10 -source 10"
	find . -type f -exec sed -i 's|-target 7 -source 7|-target 10 -source 10|g' {} \; || die

	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=()

	if use qt5; then
		mycmakeargs+=(
			-DLauncher_QT_VERSION_MAJOR=5
		)
	elif use qt6; then
		mycmakeargs+=(
			-DLauncher_QT_VERSION_MAJOR=6
		)
	fi

	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DENABLE_LTO=$(usex lto)
		-DLauncher_APP_BINARY_NAME="${PN}"
		-Bbuild -S./
	)

	cmake_src_configure
}
