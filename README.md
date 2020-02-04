# prebuilt-multiarch-bin

prebuilt gdb/gdbserver/bindshell/reverseshell binary for multiple architeture

all binaries are stripped

## Bind/Reverse Shell binary

source code is in the `src` directory.
run the bind shell without arguments like `./bind_shell` will listening on the port 3343 and `./bind_shell 6666` will listen on 6666.
run the reverse shell binary will connect to 127.0.0.1:3343 , use a hex editor the change cstring cotains the ip/port.

## GDB

gdb/gdbserver is in `ARCH/gdb-x.x.x` directory
