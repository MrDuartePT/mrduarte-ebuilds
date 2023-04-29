# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/hyprwm/contrib.git"

DESCRIPTION="Community scripts and utilities for Hypr projects"
HOMEPAGE="https://github.com/hyprwm/contrib"

DEPEND="app-portage/smart-live-rebuild"

LICENSE="GPL-2"
SLOT="0"
IUSE="grimblast scratchpad shellevents hyprprop"
REQUIRED_USE="|| ( grimblast scratchpad shellevents hyprprop )"
BUILD_TARGETS="install"

src_install() {
    if use grimblast; then
        cd ${S}/grimblast
        newbin grimblast grimblast
        dodoc grimblast.1.scd
    fi

    if use scratchpad; then
        cd ${S}/scratchpad
        newbin scratchpad scratchpad
    fi
    
    if use shellevents; then
        cd ${S}/shellevents
        newbin shellevents shellevents
        newbin shellevents_default.sh shellevents_default.sh
    fi
    
    if use hyprprop; then
        cd ${S}/hyprprop
        newbin hyprprop hyprprop
        dodoc hyprprop.1.scd
    fi
    
}

