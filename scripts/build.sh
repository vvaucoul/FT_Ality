#!/bin/bash

# check if ghc is installed
echo "GHC is not installed."
wget https://downloads.haskell.org/~ghc/9.2.8/ghc-9.2.8-x86_64-deb10-linux.tar.xz -O ghc.tar.xz
tar -xf ghc.tar.xz
cd ghc-9.2.8
./configure
