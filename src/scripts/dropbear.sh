cd buildroot-${BUILDROOT_VERSION}
export TARGET_A=${TARGET_ARCH}
unset TARGET_ARCH
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
make zlib
make zlib-ng
make dropbear
export PATH=$PATH:`pwd`/output/host/bin
${M}-strip output/build/dropbear-*/dropbearmulti
ls -al output/build/dropbear-*/dropbearmulti
file output/build/dropbear-*/dropbearmulti
mv output/build/dropbear-*/dropbearmulti ../${TARGET_A}/
sed -i "s/BR2_STATIC_LIBS=y/BR2_SHARED_STATIC_LIBS=y/g" ./.config
