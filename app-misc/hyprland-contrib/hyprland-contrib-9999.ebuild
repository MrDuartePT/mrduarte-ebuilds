# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/hyprwm/contrib.git"

DESCRIPTION="Community scripts and utilities for Hypr projects"
HOMEPAGE="https://github.com/hyprwm/contrib"

LICENSE="GPL-2"
SLOT="0"
IUSE="grimblast scratchpad shellevents"
BUILD_TARGETS="install"

src_install() {
    if use grimblast; then
        cd grimblast
        emake CC="$(tc-getCC)" \
		    CPPFLAGS="${CPPFLAGS}" \
		    CFLAGS="${CFLAGS}" \
		    LDFLAGS="${LDFLAGS}"
    fi

    if use scratchpad; then
        cd scratchpad
        emake CC="$(tc-getCC)" \
		    CPPFLAGS="${CPPFLAGS}" \
		    CFLAGS="${CFLAGS}" \
		    LDFLAGS="${LDFLAGS}"
    fi
    
    if use shellevents; then
        cd shellevents
        emake CC="$(tc-getCC)" \
		    CPPFLAGS="${CPPFLAGS}" \
		    CFLAGS="${CFLAGS}" \
		    LDFLAGS="${LDFLAGS}"
    fi
}

