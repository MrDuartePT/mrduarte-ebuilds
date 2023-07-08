# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop
SRC_URI="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v${PV}/heroic-${PV}.tar.xz"
DESCRIPTION="A Native GOG and Epic Games Launcher for Linux, Windows and Mac."
HOMEPAGE="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"

LICENSE="GPL-3"
SLOT="0"

KEYWORD="~amd64 ~x86"

src_install() {
	insinto /opt/Heroic-Game-Launcher
	doins "${WORKDIR}/${P}/dist/linux-unpacked/*"
	fperms +x /opt/Heroic-Game-Launcher/heroic

	domenu "${WORKDIR}/${P}/sioyek.desktop"
	newicon "${WORKDIR}/${P}/build/icon.png" heroic.png
}
