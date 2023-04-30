# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
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
    sed -i 'Path=d' src/resources/OneDriveGUI.desktop
    sed -i 's/Icon=/home/bob/host_share/Python/OneDriveGUI/src/resources/images/icons8-clouds-48.png/OneDriveGUI.ico/g' src/resources/OneDriveGUI.desktop
    newbin src/OneDriveGUI.py OneDriveGUI
    domenu src/resources/OneDriveGUI.desktop
    doicon src/resources/images/OneDriveGUI.ico
}

