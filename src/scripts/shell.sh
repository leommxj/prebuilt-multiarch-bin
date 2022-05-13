source ./path.sh
cd src/shell
make all M=${M}
make strip M=${M}
ls -al bind_shell reverse_shell bind_shell.so reverse_shell.so
file bind_shell reverse_shell bind_shell.so reverse_shell.so
mv bind_shell reverse_shell bind_shell.so reverse_shell.so ../../${CFG_TARGET_ARCH}/||echo "fuck"
