# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#NEED A NPM OR YARN ECLASS

EAPI=8

inherit git-r3 desktop
EGIT_REPO_URI="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher.git"
DESCRIPTION="A Native GOG and Epic Games Launcher for Linux, Windows and Mac."
HOMEPAGE="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="sys-apps/yarn"

src_unpack() {
	#clone the repo
	git-r3_src_unpack
	#dowload yarn dependency (hack way)
	cd "${S}" && yarn
}

src_compile() {
	yarn dist:linux
}
src_install() {
	insinto /opt
	mv "${WORKDIR}/${P}/dist/linux-unpacked" "${WORKDIR}/heroic"
	doins -r "${WORKDIR}/heroic"
	insinto /opt/bin
	doins "${FILESDIR}/heroic"
	fperms +x /opt/heroic/resources/app.asar.unpacked/build/bin/linux/{legendary, gogdl}
	fperms +x /opt/heroic/heroic /opt/bin/heroic

	domenu "${FILESDIR}/HeroicGamesLauncher.desktop"
	newicon "${WORKDIR}/${P}/public/icon.png" heroic.png
}
