# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit linux-mod toolchain-funcs
inherit git-r3
inherit distutils-r1
inherit desktop

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
        python? ( dev-python/argcomplete )
		app-portage/smart-live-rebuild"
LICENSE="GPL-2"
SLOT="0"
IUSE="python"

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
	if use python; then
		cd .. && cd python/legion_linux/
		distutils-r1_python_install_all
		#Desktop Files and Polkit
		cd legion_linux
		domenu legion_gui.desktop
		doicon legion_logo.png
		insinto /usr/share/polkit-1/actions/ && doins legion_gui.policy
	fi
}

