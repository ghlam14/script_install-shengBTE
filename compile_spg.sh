#!/bin/bash

mkdir -p bin

tar -xf spglib-2.0.2.tar.gz


cd spglib-2.0.2/
    echo ""
    echo "  build  spglib-master  "
    if [ -d build ] ; then
        rm -r build
    fi

    mkdir build/

    cd build/
        cmake -DCMAKE_INSTALL_PREFIX=../../bin/spglib ..
        cmake --build .
        cmake --install . --prefix ../../bin/spglib
cd ..

exit
