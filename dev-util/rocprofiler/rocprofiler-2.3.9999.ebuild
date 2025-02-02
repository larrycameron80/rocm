# Copyright
#

EAPI=6

inherit git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/ROCmSoftwarePlatform/rocprofiler.git"
EGIT_REPO_URI="https://github.com/ROCmSoftwarePlatform/rocprofiler.git"
EGIT_BRANCH="roc-2.3.x"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="media-libs/hsa-amd-aqlprofile
         dev-libs/rocr-runtime"
DEPEND="${RDPEND}
	dev-util/cmake"

PATCHES=(
        "${FILESDIR}/rocminfo-python2.patch"
)

src_configure() {
        mkdir -p "${WORKDIR}/build/"
        cd "${WORKDIR}/build/"

	export CMAKE_PREFIX_PATH=/usr/include/hsa:/usr/lib/

	if use debug; then
		export CMAKE_BUILD_TYPE=debug
#		export CMAKE_DEBUG_TRACE=1
#		export CMAKE_LD_AQLPROFILE=1
	fi

	cmake -DCMAKE_INSTALL_PREFIX="${EPREFIX}/opt/rocm"  ${S}
}

src_compile() {
        cd "${WORKDIR}/build/"
        make
}

src_install() {
        cd "${WORKDIR}/build/"
	emake DESTDIR="${D}" install
}

pkg_postinst() {
        elog "If there is an error about \"aqlprofile ...\", try to preload the library libhsa-amd-aqlprofile64.so"
        elog "> LD_PRELOAD=/usr/lib64/libhsa-amd-aqlprofile64.so.1.0.0 [command]"
}

