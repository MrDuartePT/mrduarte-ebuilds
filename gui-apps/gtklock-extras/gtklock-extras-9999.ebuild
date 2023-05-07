# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/MrDuartePT/gtklock-modules-gentoo.git"
DESCRIPTION="Gtklock modules"
HOMEPAGE="https://github.com/jovanlanik/gtklock"

LICENSE="GPL-3"
SLOT="0"
DEPEND="x11-libs/gtk+
        virtual/pkgconfig
        playerctl? ( dev-go/act )
        playerctl? ( net-libs/libsoup )
        userinfo? ( sys-apps/accountsservice )
        app-portage/smart-live-rebuild"
IUSE="playerctl powerbar userinfo"
REQUIRED_USE="|| ( playerctl powerbar userinfo )"

src_install() {
    if use powerbar; then
       pushd gtklock-powerbar-module || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi

    if use powerbar; then
       pushd gtklock-playerctl-module || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi
    
    if use userinfo; then
       pushd gtklock-userinfo-module || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi
}
