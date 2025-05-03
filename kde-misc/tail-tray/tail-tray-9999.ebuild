# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tailscale tray menu and UI for the KDE Plasma Desktop"
HOMEPAGE="https://github.com/SneWs/tail-tray"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SneWs/${PN}.git"
else
	SRC_URI="
		https://github.com/SneWs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="davfs"

BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

RDEPEND="
    net-vpn/tailscale
	dev-qt/qtbase:6
	dev-qt/qttools:6
	davfs? ( net-fs/davfs2 )
"

multilib_src_configure() {
	local mycmakeargs=()

	if ! use davfs; then
		mycmakeargs+=(
			-DDAVFS_ENABLED=OFF
		)
	fi

	mycmakeargs=(
		-DCMAKE_BUILD_TYPE="Release"
		-Bbuild -S./
	)

	cmake_src_configure
}
