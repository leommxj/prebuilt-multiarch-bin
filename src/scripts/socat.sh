cd buildroot-${BUILDROOT_VERSION}
export TARGET_A=${TARGET_ARCH}
unset TARGET_ARCH
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
make socat
export PATH=$PATH:`pwd`/output/host/bin
${M}-strip output/build/socat-*/socat
ls -al output/build/socat-*/socat
file output/build/socat-*/socat
mv output/build/socat-*/socat ../${TARGET_A}/
sed -i "s/BR2_STATIC_LIBS=y/BR2_SHARED_STATIC_LIBS=y/g" ./.config
