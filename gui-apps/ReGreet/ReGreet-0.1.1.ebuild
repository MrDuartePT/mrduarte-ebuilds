# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

SRC_URI="https://github.com/rharish101/ReGreet/archive/refs/tags/${PV}.tar.gz"
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

LICENSE="GPL-3"
SLOT="0"
DEPEND="x11-libs/gtk+:3
        gtk4? ( gui-libs/gtk )
        cage? ( gui-wm/cage )
        sway? ( gui-wm/sway )
        || ( gui-wm/cage gui-wm/sway )
"

RDEPEND="
	${DEPEND}
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
"
IUSE="gtk4 logs cage sway"
REQUIRED_USE="|| ( cage sway ) cage? ( !sway ) sway? ( !cage )"

KEYWORDS="~amd64 ~x86"

src_configure() {
    if use gtk4; then
        local myfeatures=(
            gtk4_8
        )
    fi
    cargo_src_configure
}

src_compile() {
    cargo_src_compile
}

src_install() {
    newbin ${WORKDIR}/${P}/target/release/regreet regreet
    if use cage; then
        insinto /etc/greetd/ && newins ${FILESDIR}/config-cage.toml config.toml
        echo "Restart cage service to verify if works (Only activate on TTY1)"
    fi
    if use sway; then
        insinto /etc/greetd/ && newins ${FILESDIR}/config-sway.toml config.toml
        insinto /etc/greetd/ && doins ${FILESDIR}/sway-config
        echo "Restart cage service to verify if works (Only activate on TTY1)"
    fi
}

src_post_install () {
    if use logs; then
        insinto /etc/tmpfiles.d/ && newins ${WORKDIR}/${P}/systemd-tmpfiles.conf regreet.conf
        systemd-tmpfiles --create "$PWD/systemd-tmpfiles.conf"
    fi
}