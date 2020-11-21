#!/bin/bash

echo 'export PATH=$PATH:`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/bin' > ./path.sh

if [[ "${TARGET_ARCH}" == "mips1" ]] || [[ "${TARGET_ARCH}" == "mips1el" ]]; then
	echo "BUILDROOT_VERSION=2014.11" >> $GITHUB_ENV
	echo "GDB_VERSION=7.12.1" >> $GITHUB_ENV
	sudo apt-get install gcc-4.8 g++-4.8
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100
	sudo update-alternatives --config gcc
	gcc --version
	echo 'export PATH=$PATH:`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/usr/bin' > ./path.sh
fi

echo "CFG_TARGET_ARCH=${TARGET_ARCH}" >> $GITHUB_ENV

if [[ "${TARGET_ARCH}" == "mips1" ]]; then
	echo "TARGET_ARCH=mips" >> $GITHUB_ENV
	echo "M=mips-buildroot-linux-uclibc" >> $GITHUB_ENV
fi

if [[ "${TARGET_ARCH}" == "mips1el" ]]; then
	echo "TARGET_ARCH=mipsel" >> $GITHUB_ENV
	echo "M=mipsel-buildroot-linux-uclibc" >> $GITHUB_ENV
fi

if [[ "${TARGET_ARCH}" == "mipsr6" ]]; then
	echo "TARGET_ARCH=mips" >> $GITHUB_ENV
	echo "M=mips-linux" >> $GITHUB_ENV
fi

if [[ "${TARGET_ARCH}" == "mipsr6el" ]]; then
	echo "TARGET_ARCH=mipsel" >> $GITHUB_ENV
	echo "M=mipsel-linux" >> $GITHUB_ENV
fi

if [[ "${TARGET_ARCH}" == "mips64r6" ]]; then
	echo "TARGET_ARCH=mips64" >> $GITHUB_ENV
	echo "M=mips64-linux" >> $GITHUB_ENV
fi

if [[ "${TARGET_ARCH}" == "mips64r6el" ]]; then
	echo "TARGET_ARCH=mips64el" >> $GITHUB_ENV
	echo "M=mips64el-linux" >> $GITHUB_ENV
fi
