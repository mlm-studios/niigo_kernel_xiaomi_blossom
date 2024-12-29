#!/bin/bash

set -e

if [ -z "$1" ]; then
echo "Error: Enter the defconfig"
exit
fi

#if [ -z "$2" == --clang ]; then
echo "Using clang."
export LLVM=1
CC=clang
LLVM_IAS=1
CLANG_TRIPLE=aarch64-linux-gnu-
#fi

if [ ! -d "../aarch64-linux-android-4.9" ]; then
echo "GCC toolchain not avaliable at $../aarch64-linux-android-4.9"
exit
fi

rm -rf out && mkdir out

make clean && make mrproper

export CROSS_COMPILE="$(pwd)/../aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64
export O=out

make $1 O=out

make -j$(nproc) O=out
