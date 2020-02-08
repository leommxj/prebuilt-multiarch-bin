wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz
tar xf buildroot-${BUILDROOT_VERSION}.tar.gz
cp src/cfg/${TARGET_ARCH}/buildroot_config buildroot-${BUILDROOT_VERSION}/.config
cd buildroot-${BUILDROOT_VERSION}
make toolchain
