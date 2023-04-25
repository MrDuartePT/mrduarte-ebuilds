# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod toolchain-funcs

inherit git-r3
EGIT_REPO_URI="https://github.com/johnfanv2/LenovoLegionLinux.git"

DESCRIPTION="Lenovo Legion Linux (LLL) brings additional drivers and tools for Lenovo Legion series laptops to Linux."
HOMEPAGE="https://github.com/johnfanv2/LenovoLegionLinux"

DEPEND="sys-kernel/linux-headers
        sys-apps/lm-sensors
        sys-apps/dmidecode
        python? ( dev-python/PyQt5 )
        python? ( dev-python/pyyaml )
        python? ( dev-python/pyyaml )
        python? ( dev-python/pyyaml )
        python? ( dev-python/argcomplete )"

LICENSE="GPL-2"
SLOT="0"
IUSE="python" #Config Later

MODULE_NAMES="legion-laptop(kernel/drivers/platform/x86:kernel_module)"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
        export KERNELRELEASE=${KV_FULL}
}

src_compile() {
        linux-mod_src_compile
}

src_install() {
        linux-mod_src_install
	cd kernel_module
	make forcereloadmodule
}
