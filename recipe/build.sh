#!/bin/bash
set -ex

export CFLAGS="${CFLAGS} -O3 -fPIC"
export LDFLAGS="${LDFLAGS} -Wl,-rpath,${PREFIX}/lib"

# Remove Werror from compiler flags
sed -ie 's/-Werror//g' CMakeLists.txt
mkdir build && cd build

cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=$PREFIX $SRC_DIR
make -j$CPU_COUNT && make test && make install
