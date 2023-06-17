# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

EPYTHON=python3

inherit linux-mod-r1 toolchain-funcs git-r3 distutils-r1 desktop

EGIT_REPO_URI="https://github.com/johnfanv2/LenovoLegionLinux.git"

DESCRIPTION="Lenovo Legion Linux kernel module"
HOMEPAGE="https://github.com/johnfanv2/LenovoLegionLinux"

DEPEND="sys-kernel/linux-headers
        sys-apps/lm-sensors
        sys-apps/dmidecode
        python? ( dev-python/PyQt5 )
        python? ( dev-python/pyyaml )
        python? ( dev-python/argcomplete )
		app-portage/smart-live-rebuild
		acpi? ( sys-power/acpid )"
LICENSE="GPL-2"
SLOT="0"
IUSE="python acpi"

#MODULE_NAMES="legion-laptop(kernel/drivers/platform/x86:kernel_module)"
#BUILD_TARGETS="all"
MODULES_KERNEL_MIN=5.10

src_compile() {
	local modlist=(
		legion-laptop=kernel/drivers/platform/x86:kernel_module:kernel_module:all
	)
	BUILD_FIXES="KERNELVERSION=${KV_FULL}"
    linux-mod-r1_src_compile
	if use python; then
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux"
		distutils-r1_src_compile --build-dir "${WORKDIR}/${P}/python/legion_linux/build"
	fi
}

src_install() {
	linux-mod-r1_src_install
	#Load the module without reboot
	cd "${WORKDIR}/${P}/python/legion_linux/"
	make forcereloadmodule
	if use python; then
		#Define build dir (fix sandboxed)
		cd "${WORKDIR}/${P}/python/legion_linux/"
		distutils-r1_src_install --build-dir "${WORKDIR}/${P}/python/legion_linux/build"

		if use acpi; then
            insinto /etc/acpi/events/ && doins "${FILESDIR}/novo-button"
        fi

		# Desktop Files and Polkit
		domenu "${FILESDIR}/legion_gui.desktop"
		doicon "${WORKDIR}/${P}/python/legion_linux/legion_linux/legion_logo.png"
		insinto "/usr/share/polkit-1/actions/" && doins "${FILESDIR}/legion_cli.policy"
	fi
}

