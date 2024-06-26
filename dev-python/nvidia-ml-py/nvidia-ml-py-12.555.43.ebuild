# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )
PYPI_NO_NORMALIZE=1
PYPI_PN="nvidia-ml-py"
inherit distutils-r1 pypi

DESCRIPTION="Python Bindings for the NVIDIA Management Library"
HOMEPAGE="
		https://pypi.org/project/nvidia-ml-py/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

