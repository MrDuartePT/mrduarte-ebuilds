# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils desktop
EGIT_REPO_URI="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher.git"
DESCRIPTION="A Native GOG and Epic Games Launcher for Linux, Windows and Mac."
HOMEPAGE="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="sys-apps/yarn"

src_compile() {
	#Build linux binary
	yarn dist:mac
}
src_install() {
	insinto /opt/Heroic-Game-Launcher
	doins "${WORKDIR}/${P}/dist/linux-unpacked/*"
	fperms +x /opt/Heroic-Game-Launcher/heroic

	domenu "${WORKDIR}/${P}/sioyek.desktop"
	newicon "${WORKDIR}/${P}/build/icon.png" heroic.png
}
