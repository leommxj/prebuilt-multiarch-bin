#!/bin/bash

echo 'export PATH=$PATH:`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/bin' > ./path.sh

if [[ "${TARGET_ARCH}" == "mips1" ]] || [[ "${TARGET_ARCH}" == "mipsel1" ]]; then
	echo "::set-env name=BUILDROOT_VERSION::2014.11"
	echo "::set-env name=GDB_VERSION::7.12.1"
	sudo apt-get install gcc-4.8 g++-4.8
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100
	sudo update-alternatives --config gcc
	gcc --version
	echo 'export PATH=$PATH:`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/usr/bin' > ./path.sh
fi

echo "::set-env name=CFG_TARGET_ARCH::${TARGET_ARCH}"

if [[ "${TARGET_ARCH}" == "mips1" ]] || [[ "${TARGET_ARCH}" == "mipsel1" ]]; then
	echo "::set-env name=TARGET_ARCH::${TARGET_ARCH%1}"
	echo "::set-env name=M::${TARGET_ARCH%1}-buildroot-linux-uclibc"
fi
