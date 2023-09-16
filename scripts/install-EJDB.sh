#!/usr/bin/env bash

# Install cmake
sudo apt-get -y install cmake

# Clone project from https://github.com/Softmotions/ejdb
git clone --recurse-submodules https://github.com/Softmotions/ejdb.git

# Build and install
cd ejdb
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install