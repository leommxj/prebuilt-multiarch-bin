source path.sh
cd buildroot-${BUILDROOT_VERSION}
sed -i "s/BR2_SHARED_STATIC_LIBS=y/BR2_STATIC_LIBS=y/g" ./.config
# normal busybox
make busybox-dirclean
make busybox
${M}-strip output/build/busybox-*/busybox
ls -al output/build/busybox-*/busybox
file output/build/busybox-*/busybox
mv output/build/busybox-*/busybox ../${CFG_TARGET_ARCH}/
# busybox without BB_SUID_DROP
make busybox-dirclean
cat << EOF >> package/busybox/busybox.mk
define BUSYBOX_SWITCH_SUID_HACK
        grep -e "applet:.*BB_SUID_DROP" -rl \$(@D)/ |xargs sed -i 's/\(applet:.*\)BB_SUID_DROP/\1BB_SUID_MAYBE/g'
endef
BUSYBOX_POST_CONFIGURE_HOOKS += BUSYBOX_SWITCH_SUID_HACK
EOF
make busybox
${M}-strip output/build/busybox-*/busybox
ls -al output/build/busybox-*/busybox
file output/build/busybox-*/busybox
mv output/build/busybox-*/busybox ../${CFG_TARGET_ARCH}/busybox_nodrop
sed -i "s/BR2_STATIC_LIBS=y/BR2_SHARED_STATIC_LIBS=y/g" ./.config
