# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/Petingoso/legion-fan-utils-linux.git"

DESCRIPTION="Small Scripts that allow to change fan speed and GPU & CPU power limit on legion laptops"
HOMEPAGE="https://github.com/Petingoso/legion-fan-utils-linux"

DEPEND="dev-lang/python
        dev-python/psutil
        radeon_dgpu? ( dev-util/rocm-smi )
        downgrade-nvidia? ( =x11-drivers/nvidia-drivers-525.105.17 )
        acpi? ( sys-power/acpid )"
LICENSE="GPL-2"
SLOT="0"
IUSE="systemd acpi radeon_dgpu downgrade-nvidia"

src_install() {
    insinto /etc/lenovo-fan-control/ && doins service/fancurve-set.sh
    insinto /etc/lenovo-fan-control/profiles/ && doins service/profiles/*
    insinto /usr/local/bin/ && doins service/lenovo-legion-fan-service.py && doins profile_man.py
    fperms +x /etc/lenovo-fan-control/fancurve-set.sh

    #AMD
    if use radeon_dgpu; then
        cp .env-files/radeon .env
        insinto /etc/lenovo-fan-control/ && doins .env
    fi

    #NVIDIA (need dowgrade because nvidia-smi -pl was removed)
    if use downgrade-nvidia; then 
        cp .env-files/nvidia .env
        insinto /etc/lenovo-fan-control/ && doins .env
    fi

	if use systemd; then
        insinto /etc/systemd/system/ && doins service/*.service && doins service/*.path
        
        if use acpi; then
        insinto /etc/acpi/events/ && doins service/ac_adapter_legion-fancurve
        fi
        
        systemctl daemon-reload
        systemctl enable --now lenovo-fancurve.service 
        systemctl enable --now lenovo-fancurve-restart.path lenovo-fancurve-restart.service
	fi
}

