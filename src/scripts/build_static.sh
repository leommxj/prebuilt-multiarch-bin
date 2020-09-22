source path.sh
cd buildroot-${BUILDROOT_VERSION}
export TARGET_A=${CFG_TARGET_ARCH}
unset TARGET_ARCH
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
make $1
${M}-strip output/build/$1-*/$1
ls -al output/build/$1-*/$1
file output/build/$1-*/$1
mv output/build/$1-*/$1 ../${TARGET_A}/
sed -i "s/BR2_STATIC_LIBS=y/BR2_SHARED_STATIC_LIBS=y/g" ./.config
