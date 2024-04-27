# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils
EGIT_REPO_URI="https://github.com/MrDuartePT/deckifier-hyprland.git"
EGIT_BRANCH="hyprland"
DESCRIPTION="Steam Deck UI - On Hyprland compositor"
HOMEPAGE="https://github.com/MrDuartePT/deckifier-hyprland"

LICENSE="MIT"
SLOT="0"

IUSE="hyprland-sddm hyprland-greetd hyprland-lightdm kde"
REQUIRED_USE="^^ ( hyprland-sddm hyprland-greetd hyprland-lightdm kde )"

RDEPEND="gui-wm/gamescope
	games-util/steam-launcher
	games-util/mangohud
	dev-python/evdev
"

src_unpack() {
	if use hyprland-greetd; then
		EGIT_BRANCH="hyprland-greetd"
	elif use hyprland-lightdm; then
		EGIT_BRANCH="lightdm"
	elif use kde; then
		EGIT_BRANCH="kde"
	fi

	git-r3_src_unpack
}

src_install() {
	insinto "etc/"
	doins -r "${S}/rootfs/etc/systemd"
	doins -r "${S}/rootfs/etc/polkit-1"
	insinto "usr/"
	doins -r "${S}/rootfs/usr/bin"
	doins -r "${S}/rootfs/usr/lib"
	doins -r "${S}/rootfs/usr/share"

	fperms +x "/usr/lib/os-session-select"
	fperms +x "/usr/bin/export-gpu"
	fperms +x "/usr/bin/gamescope-session"
	fperms +x "/usr/bin/steamos-session-select"
	#fperms +x "/usr/bin/steam-powerbuttond"

	fperms +x "/usr/share/gamescope-session/gamescope-session-script"

	fperms a+x "/usr/share/applications/org.valve.gamescope.desktop"
}

post_intall() {
	ewarn "Futher setup is require:"
	ewarn "Pls edit org.valve.steamvr.policy inside /usr/share/polkit-1/actions and in line 14 replace /home/mrduarte with your username"
	ewarn ""
	ewarn "You also need to run: gio set /usr/share/applications/org.valve.gamescope.desktop metadata::trusted true"
	ewarn ""
	ewarn "Repo also have instrution for non Hyprland user (you need to bakcup usr/lib/os-session-select on any update or create a patch for your version)"
	ewarn "More info in the readme: https://github.com/MrDuartePT/deckifier-hyprland/blob/main/README.md"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
