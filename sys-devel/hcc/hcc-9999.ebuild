# Copyright
# 

EAPI=6
inherit cmake-utils git-r3

DESCRIPTION="HCC - An open source C++ compiler for heterogeneous devices"
HOMEPAGE="https://github.com/RadeonOpenCompute/hcc"
EGIT_REPO_URI="https://github.com/RadeonOpenCompute/hcc.git"
EGIT_SUBMODULES=('*')
EGIT_BRANCH="clang_tot_upgrade"

LICENSE=""
SLOT="9999"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="media-libs/ROCR-Runtime
         sys-libs/libunwind"

CMAKE_BUILD_TYPE="Release"

src_configure() {

        local mycmakeargs=(
                -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/hcc/${SLOT}"
                -DCMAKE_INSTALL_MANDIR="${EPREFIX}/usr/lib/hcc/${SLOT}/share/man"
        )

        cmake-utils_src_configure
}
