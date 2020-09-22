wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz
tar xf buildroot-${BUILDROOT_VERSION}.tar.gz
cp src/cfg/${CFG_TARGET_ARCH}/buildroot_config buildroot-${BUILDROOT_VERSION}/.config
cd buildroot-${BUILDROOT_VERSION}
make toolchain
make sdk || tar -czf ../${CFG_TARGET_ARCH}_sdk-buildroot.tar.gz ./output/host
mv ./output/images/*_sdk-buildroot.tar.gz ../${CFG_TARGET_ARCH}_sdk-buildroot.tar.gz || echo ""
