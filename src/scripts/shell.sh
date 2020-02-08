export PATH=$PATH:`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/bin
cd src/shell
make all M=${M}
${M}-strip bind_shell
${M}-strip reverse_shell
ls -al bind_shell reverse_shell
file bind_shell reverse_shell
mv bind_shell ../../${TARGET_ARCH}/
mv reverse_shell ../../${TARGET_ARCH}/
