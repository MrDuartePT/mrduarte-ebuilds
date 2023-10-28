# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils
EGIT_REPO_URI="https://github.com/MrDuartePT/deckifier-hyprland.git"
DESCRIPTION="Steam Deck UI - On Hyprland compositor"
HOMEPAGE="https://github.com/MrDuartePT/deckifier-hyprland"

LICENSE="MIT"
SLOT="0"

RDEPEND="gui-wm/gamescope
	games-util/steam-client-meta
	games-util/mangohud
"

src_install() {
	insinto "etc/"
	doins -r "${S}/rootfs/etc/systemd"
	doins -r "${S}/rootfs/etc/greetd"
	doins -r "${S}/rootfs/etc/polkit-1"
	insinto "usr/"
	doins -r "${S}/rootfs/usr/lib"
	doins -r "${S}/rootfs/usr/share"

	#File inside /rootfs/usr/bin
	dobin "${S}/rootfs/usr/bin/export-gpu"
	dobin "${S}/rootfs/usr/bin/gamescope-session"
	dobin "${S}/rootfs/usr/bin/steamos-session-select"
	dobin "${S}/rootfs/usr/bin/steam-http-loader"
	dobin "${S}/rootfs/usr/bin/jupiter-biosupdate"
	dobin "${S}/rootfs/usr/bin/steamos-update"

	#File inside /rootfs/usr/bin/steamos-polkit-helpers
	insinto "usr/libexec/"
	doins -r "${S}/rootfs/usr/libexec/steamos-polkit-helpers"

	fperms a+x "/usr/share/applications/org.valve.gamescope.desktop"
	fperms +x "/usr/lib/os-session-select"
	fperms +x "/usr/share/gamescope-session/gamescope-session-script"
	fperms +x "/usr/libexec/steamos-polkit-helpers/jupiter-biosupdate"
	fperms +x "/usr/libexec/steamos-polkit-helpers/steamos-update"
	fperms +x "/usr/libexec/steamos-polkit-helpers/steamos-set-hostname"
	fperms +x "/usr/libexec/steamos-polkit-helpers/steamos-set-timezone"
	fperms +x "/usr/libexec/steamos-polkit-helpers/steamos-priv-write"
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
