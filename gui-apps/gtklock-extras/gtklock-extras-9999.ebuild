# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/MrDuartePT/gtklock-modules-gentoo.git"
DESCRIPTION="Gtklock modules"
HOMEPAGE="https://github.com/jovanlanik/gtklock"

DEPEND="app-portage/smart-live-rebuild"

LICENSE="GPL-2"
SLOT="0"
DEPEND="x11-libs/gtk+
        virtual/pkgconfig
        playerctl? ( dev-go/act )
        playerctl? ( net-libs/libsoup )
        userinfo? ( sys-apps/accountsservice )"
IUSE="playerctl powerbar userinfo"
REQUIRED_USE="|| ( playerctl powerbar userinfo )"

src_install() {
    if use playerctl; then
        cd ${S}/gtklock-powerbar-module
        make
        insinto /usr/local/lib/gtklock/ && doins powerbar-module.so
    fi

    if use powerbar; then
        cd ${S}/gtklock-playerctl-module
        make
        insinto /usr/local/lib/gtklock/ && doins playerctl-module.so
    fi
    
    if use userinfo; then
        cd ${S}/gtklock-userinfo-module
        make
        insinto /usr/local/lib/gtklock/ && doins userinfo-module.so
    fi
}

