#!/bin/bash

set -ex

export CFLAGS="${CFLAGS} -O3 -fPIC"
export LDFLAGS="${LDFLAGS} -Wl,-rpath,${PREFIX}/lib"

# Remove Werror from compiler flags
sed -ie 's/-Werror//g' CMakeLists.txt

pushd . && mkdir build && cd build

# https://conda-forge.org/blog/posts/2020-10-29-macos-arm64/
cmake ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX:PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release $SRC_DIR

cmake --build . --config Release
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
    cmake --build . --config Release --target test
fi
cmake --build . --config Release --target install

popd && rm -rf build
