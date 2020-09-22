source ./path.sh
cd src/shell
make all M=${M}
${M}-strip bind_shell
${M}-strip reverse_shell
ls -al bind_shell reverse_shell
file bind_shell reverse_shell
mv bind_shell ../../${CFG_TARGET_ARCH}/
mv reverse_shell ../../${CFG_TARGET_ARCH}/
