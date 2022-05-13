source path.sh
cd buildroot-${BUILDROOT_VERSION}
export TARGET_A=${CFG_TARGET_ARCH}
unset TARGET_ARCH
cp ./.config ./.config.bak
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
echo -ne "\nBR2_PACKAGE_DROPBEAR=y\nBR2_PACKAGE_DROPBEAR_SMALL=y" >> ./.config
make olddefconfig
make dropbear
${M}-strip output/build/dropbear-*/dropbearmulti
ls -al output/build/dropbear-*/dropbearmulti
file output/build/dropbear-*/dropbearmulti
mv output/build/dropbear-*/dropbearmulti ../${TARGET_A}/
mv ./.config.bak ./.config