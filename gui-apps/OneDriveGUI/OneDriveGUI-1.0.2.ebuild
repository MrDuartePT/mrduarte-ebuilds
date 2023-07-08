# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop
SRC_URI="https://github.com/bpozdena/OneDriveGUI/archive/refs/tags/v${PV}.tar.gz"
DESCRIPTION="A simple GUI for OneDrive Linux client, with multi-account support."
HOMEPAGE="https://github.com/bpozdena/OneDriveGUI"

DEPEND="net-misc/onedrive
	dev-python/requests
	dev-python/pyside6[webengine(+)]
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	#Install binary and alias command
	insinto /opt/OneDriveGUI/ && doins -r "${WORKDIR}/${P}/src/resources" && doins -r "${WORKDIR}/${P}/src/ui" && doins -r "${WORKDIR}/${P}/src/OneDriveGUI.py"
	insinto /opt/bin/ && doins "${FILESDIR}/onedrivegui"
	fperms +x /opt/OneDriveGUI/OneDriveGUI.py /opt/bin/onedrivegui

	#Icon and Desktop File
	doicon "${WORKDIR}/${P}/src/resources/images/OneDriveGUI.ico"
	domenu "${FILESDIR}/OneDriveGUI.desktop"
}
