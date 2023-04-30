# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
inherit desktop
EGIT_REPO_URI="https://github.com/bpozdena/OneDriveGUI.git"

DESCRIPTION="Small Scripts that allow to change fan speed and GPU & CPU power limit on legion laptops"
HOMEPAGE="https://github.com/bpozdena/OneDriveGUI"

#dlang repo net-misc/onedrive

DEPEND="dev-lang/python
        net-misc/onedrive
        dev-python/requests
        dev-python/pyside6[webengine(+)]"
LICENSE="GPL-2"
SLOT="0"


src_install() {
    insinto /usr/local/bin/ && doins ${WORKDIR}/${P}/src/OneDriveGUI.py #Fix ui error on gentoo
    doicon ${WORKDIR}/${P}/src/resources/images/OneDriveGUI.ico
    domenu ${FILESDIR}/OneDriveGUI.desktop
    newbin ${FILESDIR}/OneDriveGUI.sh OneDriveGUI
}

