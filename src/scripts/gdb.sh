export PATH=`pwd`/buildroot-${BUILDROOT_VERSION}/output/host/bin:$PATH
wget https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.gz
tar xf gdb-${GDB_VERSION}.tar.gz
cd gdb-${GDB_VERSION}
sed -i -e 's/srv_linux_thread_db=yes//' gdb/gdbserver/configure.srv
./configure --target=${M} --host=${M} --program-prefix=${M}
make CFLAGS="-O2 -static" CXXFLAGS="-O2 -static" || echo "FUCK ${M}" # may failed to compile all but successful build gdb/gdbserver
$M-strip gdb/gdb
$M-strip gdb/gdbserver/gdbserver
ls -al gdb/gdb gdb/gdbserver/gdbserver
file gdb/gdb gdb/gdbserver/gdbserver
mkdir ../${TARGET_ARCH}/gdb-${GDB_VERSION}
mv gdb/gdb ../${TARGET_ARCH}/gdb-${GDB_VERSION}/
mv gdb/gdbserver/gdbserver ../${TARGET_ARCH}/gdb-${GDB_VERSION}/
echo 
