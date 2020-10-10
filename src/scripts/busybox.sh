source path.sh
cd buildroot-${BUILDROOT_VERSION}
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
make busybox-dirclean
make busybox
${M}-strip output/build/busybox-*/busybox
ls -al output/build/busybox-*/busybox
file output/build/busybox-*/busybox
mv output/build/busybox-*/busybox ../${CFG_TARGET_ARCH}/
sed -i "s/BR2_STATIC_LIBS=y/BR2_SHARED_STATIC_LIBS=y/g" ./.config
