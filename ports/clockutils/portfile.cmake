include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ClockworkOrigins/clockUtils
    REF 3651f232c27074c4ceead169e223edf5f00247c5
    SHA512 ddb70cae9ced25de77a2df1854dac15e58a77347042ba3ee9c691f85f49edbc6539c84929a7477d429fb9161ba24c57d24d767793b8b1180216d5ddfc5d3ed6a
    HEAD_REF dev-1.2
    PATCHES
        "${CURRENT_PORT_DIR}/fix-warningC4643.patch"
)

if (VCPKG_CRT_LINKAGE STREQUAL dynamic)
    SET(SHARED_FLAG ON)
else()
    SET(SHARED_FLAG OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DWITH_LIBRARY_ARGPARSER=ON
        -DWITH_LIBRARY_COMPRESSION=ON
        -DWITH_LIBRARY_CONTAINER=ON
        -DWITH_LIBRARY_INIPARSER=ON
        -DWITH_LIBRARY_SOCKETS=ON
        -DWITH_TESTING=OFF
        -DCLOCKUTILS_BUILD_SHARED=${SHARED_FLAG}
)

vcpkg_build_cmake()
vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/clockUtils)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/clockUtils/LICENSE ${CURRENT_PACKAGES_DIR}/share/clockUtils/copyright)
file(REMOVE ${CURRENT_PACKAGES_DIR}/LICENSE)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/LICENSE)

vcpkg_copy_pdbs()