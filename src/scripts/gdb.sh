source ./path.sh
wget https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.gz
tar xf gdb-${GDB_VERSION}.tar.gz
cd gdb-${GDB_VERSION}
if [[ "${GDB_VERSION}" == "7.12.1" ]];then
	sed -i "s/_obstack_free/obstack_free/g" ./include/obstack.h
fi
sed -i -e 's/srv_linux_thread_db=yes//' gdb/gdbserver/configure.srv
./configure --target=${M} --host=${M} --program-prefix=${M}
make CFLAGS="-O2 -static" CXXFLAGS="-O2 -static" || echo "FUCK ${M}" # may failed to compile all but successful build gdb/gdbserver
$M-strip gdb/gdb
$M-strip gdb/gdbserver/gdbserver
ls -al gdb/gdb gdb/gdbserver/gdbserver
file gdb/gdb gdb/gdbserver/gdbserver
mkdir ../${CFG_TARGET_ARCH}/gdb-${GDB_VERSION}
mv gdb/gdb ../${CFG_TARGET_ARCH}/gdb-${GDB_VERSION}/
mv gdb/gdbserver/gdbserver ../${CFG_TARGET_ARCH}/gdb-${GDB_VERSION}/
echo 
